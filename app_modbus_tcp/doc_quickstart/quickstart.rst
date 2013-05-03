Modbus TCP Demo Quickstart Guide
================================

This simple demonstration of xTIMEcomposer Studio functionality that uses the ``XA-SK-E100`` and ``XA-SK-GPIO`` Slice Cards together with the xSOFTip ``module_modbus_tcp`` to demonstrate how the module is used to receive commands from a Modbus Master over TCP and service them to:

- Turn GPIO Slice Card LEDS on and off
- Read the room temperature via the on-board ADC
- Display GPIO Slice Card button presses

Host Computer Setup
+++++++++++++++++++

A Modbus Master application such as Simply Modbus TCP. Simply Modbus PC application is available from http://www.simplymodbus.ca/TCPclient.htm. Download the installer and install the application on your PC by running it. You can open the Modbus master emulator using Start -> All Programs -> Simply Modbus -> Simply Modbus TCP.

Using SimplyModbus PC Application
---------------------------------

Simply Modbus TCP application is a Modbus (TCP) master emulator program that runs on a PC. Using this software, Modbus master commands could be sent to a slave over TCP. Modbus Master commands could be formed in this application by setting various parameters. Please see the online manual for SimplyModbus TCP here: http://www.simplymodbus.ca/TCPmanual.htm for help on creating Modbus commands.

The commands could also be stored (saved) and restored to/from the PC memory for later use. These saved files may also be called as configurations. The folder ($\\app_modbus_tcp\\simplymodbus_config\\) contains sample Simply Modbus TCP specific configuration files to perform Read / Write operations. These files can be loaded by clicking on ``RESTORE CFG`` button from the Simply Modbus PC application.


Hardware Setup
++++++++++++++

The Modbus TCP Demo Application requires the following items:

- XP-SKC-L2 Slicekit Core board marked with edge connectors: ``SQUARE``, ``CIRCLE``, ``TRIANGLE`` and ``STAR``.
- XA-SK-E100 Ethernet Slice Card
- XA-SK-GPIO GPIO Slice Card
- XTAG2 and XTAG Adapter
- Ethernet Cable and
- 12V DC power supply

To setup the system:

#. Connect XA-SK-E100 Slice Card to the XP-SKC-L2 Slicekit Core board using the connector marked with the ``CIRCLE``.
#. Connect XA-SK-GPIO Slice Card to the XP-SKC-L2 Slicekit Core board using the connector marked with the ``SQUARE``.
#. Connect the XTAG Adapter to Slicekit Core board, and connect XTAG-2 to the adapter.
#. Connect the XTAG-2 to host PC. Note that the USB cable is not provided with the Slicekit starter kit.
#. Connect an Ethernet cable between the XA-SK-E100 Slice Card and host PC.
#. Switch on the power supply to the Slicekit Core board.

.. figure:: images/hardware_setup.jpg
   :align: center

   Hardware Setup for a Modbus TCP Demo


Import and Build the Application
++++++++++++++++++++++++++++++++

Using xTIMEcomposer
-------------------

#. Open xTIMEcomposer and check that it is operating in online mode. Open the edit perspective (Window->Open Perspective->XMOS Edit).
#. Locate the ``Modbus TCP Demo`` item in the xSOFTip pane on the bottom left of the window and drag it into the Project Explorer window in the xTIMEcomposer. This will also cause the modules on which this application depends to be imported as well.
#. Click on the ``app_modbus_tcp`` item in the Project Explorer pane then click on the build icon (hammer) in xTIMEcomposer. Check the console window to verify that the application has built successfully.

For help in using xTIMEcomposer, try the xTIMEcomposer tutorial, which you can find by selecting (Help->Tutorials) from the xTIMEcomposer menu.

Note that the Developer Column in the xTIMEcomposer on the right hand side of your screen provides information on the xSOFTip components you are using. Select the module_modbus_tcp component in the Project Explorer, and you will see its description together with API documentation. Having done this, click the `back` icon until you return to this quick start guide within the Developer Column.

Using Command Line
------------------

The following xSOFTip are required alongside ``sc_modbus_tcp`` in the project workspace. Make sure you have them; either using ``git clone`` or downloading from the mentioned link.

- sc_ethernet https://github.com/xcore/sc_ethernet.git
- sc_i2c https://github.com/xcore/sc_i2c.git
- sc_otp https://github.com/xcore/sc_otp.git
- sc_util https://github.com/xcore/sc_util.git
- sc_xtcp https://github.com/xcore/sc_xtcp.git
- xcommon https://github.com/xcore/xcommon.git

To build from the command line, change to `app_modbus_tcp` directory and execute the command::

   xmake

Run the Application
+++++++++++++++++++

Using xTIMEcomposer
-------------------

Now that the application has been compiled, the next step is to run it on the Slicekit Core Board using the tools to load the application over JTAG (via the XTAG2 and XTAG Adapter card) into the xCORE multicore microcontroller.

- Select the file ``app_modbus_tcp.xc`` in the ``app_modbus_tcp`` project from the Project Explorer.
- Click on the ``Run`` icon (the white arrow in the green circle).
- At the ``Select Device`` dialog select ``XMOS XTAG-2 connect to L1[0..1]`` and click ``OK``.

Using Command Line
------------------

To run the ``app_modbus_tcp`` on xCORE multicore microcontroller, change to `($\\app_modbus_tcp\\bin)` directory and execute the command::

   xrun app_modbus_tcp.xe

The Demo
---------

This demo issues commands to read: coils, input register and discrete inputs and write: coils. Using the XA-SK-GPIO slice card, the coils, etc... are mapped as follows:

   ================  ====================
   Device            on XA-SK-GPIO slice
   ================  ====================
   Coils             LEDs LED0 - LED3
   Input Register    Temperature Sensor
   Discrete Input    Buttons SW1 & SW2
   Holding Register  N/A
   ================  ====================


After issuing the command to run the ``app_modbus_tcp`` on xCORE multicore microcontroller, the console output should print an IP address.

   Example: IP address: 169.254.231.27

On your PC, open the SimplyModbus Client from (Start -> All Programs -> Simply Modbus -> Simply Modbus TCP) and adjust to following settings:

   - mode = TCP
   - IP Address = user ip address provided in app_modbus_tcp.xc
   - Port = 502 (Modbus Listening Port)

Alternatively, click on ``RESTORE CFG`` and change to `($\\app_modbus_tcp\\simplymodbus_config\\)`. Select the `read_coil.csv` configuration file and click ``CONNECT``.

.. figure:: images/main.png
   :align: center

   SimplyModbus opening window with required settings



Switch ON all LEDs
~~~~~~~~~~~~~~~~~~

Switch ON all LEDs using `Write Coil` command. You can issue `write` commands using the ``WRITE`` interface. This can be brought up by clicking the ``WRITE`` button in SimplyModbus.

.. figure:: images/write.png
   :align: center

   SimplyModbus WRITE interface



Click on ``RESTORE CFG`` (in the SimplyModbus Write interface window) and change to `($\\app_modbus_tcp\\simplymodbus_config\\)`. Select the `write_coil.csv` configuration file. This will load the WRITE_SINGLE_COIL command in the SimplyModbus write window with `First Register = 1` and `# values to write = 1`. This prepares a `Write Single Coil` command to be issued to the Modbus slave to Write a coil (LED) at address indicated in `First Register` box. Note that, First Register = 1 is address 0, First Register = 2 is address 1 and so on. In this demo, toggle the states of all four LEDs one by one by changing the `First Register` value and clicking on ``SEND``. Notice how the LED state changes on the XA-SK-GPIO slice card.

.. figure:: images/write_led_0123.png
   :align: center

   Toggle LED states



Read LED status
~~~~~~~~~~~~~~~

Switch to SimplyModbus main window. Click on ``RESTORE CFG`` and change to `($\\app_modbus_tcp\\simplymodbus_config\\)`. Select the `read_coil.csv` configuration file. This will load the READ_COIL command in the SimplyModbus main window with `First Coil = 1` and `No. of Coils = 4`. This prepares a `Read Coil` command to be issued to the Modbus slave to read coils from addresses 0 through 3. In this demo, it reads the status of 4 GPIO LEDs on XA-SK-GPIO slice card. The first LED is LED0 on the XA-SK-GPIO slice and the fourth LED is LED3 XA-SK-GPIO slice. The result is a byte containing the status of LEDs arranged as bit positions (shown in `results` column in the SimplyModbus main window):

   +----+----+----+----+------+------+------+------+
   | XX | XX | XX | XX | LED3 | LED2 | LED1 | LED0 |
   +----+----+----+----+------+------+------+------+

   Where,

   * Bit0 is LED0 status (1 is OFF and 0 is ON)
   * Bit1 is LED1 status (1 is OFF and 0 is ON)
   * Bit2 is LED2 status (1 is OFF and 0 is ON)
   * Bit3 is LED3 status (1 is OFF and 0 is ON)
   * XX is Don't care.

.. figure:: images/read_led_0123.png
   :align: center

   Read LED status


Switch OFF LED1 and LED3
~~~~~~~~~~~~~~~~~~~~~~~~

Switch OFF LED1 & LED3 using `Write Coil` command. In the SimplyModbus write window change `First Register = 2` and `# values to write = 1`. This prepares a `Write Single Coil` command to be issued to the Modbus slave to Write a coil (LED) at address indicated in `First Register` box. Click on ``SEND``. Notice how LED1 state toggles. Now, set `First Register = 4` and click on ``SEND``. Notice how LED3 state toggles.

.. figure:: images/write_led_13.png
   :align: center

   Toggle LED states



Read LED status
~~~~~~~~~~~~~~~

Switch to SimplyModbus main window. Click on ``SEND``. This time, please notice the result (shown in `results` column in the SimplyModbus main window) indicates that LED1 and LED3 are OFF. The LED states are arranged as following in the result:


.. figure:: images/read_led_13.png
   :align: center

   Read LED status


Read Temperature
~~~~~~~~~~~~~~~~

The temperature can be read by sending a 'Read Input Register' command. In the SimplyModbus main window, click on ``RESTORE CFG`` and change to `($\\app_modbus_tcp\\simplymodbus_config\\)`. Select the `read_ip_reg.csv` configuration file. This will load the READ_INPUT_REGISTER command in the SimplyModbus main window with `First Register = 1` and `No. of Registers = 1`. This prepares a `Read Input Register` command to be issued to the Modbus slave to Read input registers at address 0. In this demo, it reads the current room temperature as recorded by the sensor present on the XA-SK-GPIO slice card. The result (shown in `results` column in the SimplyModbus main window) is a short integer representing the room temperature as responded by the Modbus slave.

.. figure:: images/read_temp.png
   :align: center

   Read Room Temperature



Read Button States - No Buttons pressed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To see if a button was pressed (and released) since last read, send a 'Read Discrete Input' command. Click on ``RESTORE CFG`` and change to `($\\app_modbus_tcp\\simplymodbus_config\\)`. Select the `read_dis_ip.csv` configuration file. This will load the READ_DISCRETE_INPUT command in the SimplyModbus main window with `First Coil = 1` and `No. of Coils = 2`. This prepares a `Read Discrete Input` command to be issued to the Modbus slave to Read input registers at addresses 0 through 1. In this demo, it reads button (SW1 & SW2) status on the XA-SK-GPIO slice card. Address 0 is SW1 and Address 1 is SW2. The result (shown in `results` column in the SimplyModbus main window) is a byte of format:

   +----+----+----+----+----+----+-----+-----+
   | XX | XX | XX | XX | XX | XX | SW2 | SW1 |
   +----+----+----+----+----+----+-----+-----+

   Where,

   * Bit0 is SW1 status (1 was Button Pressed and released since last read)
   * Bit1 is SW2 status (1 was Button Pressed and released since last read)
   * XX is Don't care.

.. figure:: images/read_btn_00.png
   :align: center

   Read Button Status



Read Button States - SW1 & SW2 pressed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now press Button SW1 & SW2 on the XA-SK-GPIO slice card. In the SimplyModbus main window, click ``SEND`` again to read the button status. This time, the result byte shows that both buttons were pressed.

.. figure:: images/read_btn_11.png
   :align: center

   Read Button Status


Other commands
~~~~~~~~~~~~~~

User can change appropriate values of address and data based on their application. Any unsupported Function code or data range will result in exception response.

For example, when a Function code '7' (Read Exception Status) is sent to the slave, the slave returns an 'Illegal Function Code' error response as the slave does not support this command.

.. figure:: images/ill_fn.png
   :align: center

   Illegal Function Code Screenshot   

Another example where the number of coils in 'Read Coil' (function code '1') command is set to 80000 and is sent to Modbus slave. The slave returns an 'Illegal Data Value' error response as that number of coils is not supported by the slave.

.. figure:: images/ill_data.png
   :align: center

   Illegal Data Value Screenshot   


Next Steps
++++++++++

.. list-table:: Project structure
  :header-rows: 1

  * - Project
    - File
    - Description
  * - module_modbus_tcp
    - ``modbus_tcp.h``
    - Header file containing the APIs for the Modbus TCP component
  * - app_modbus_tcp
    - ``app_modbus_tcp.xc``
    - File containing main() function for the application. Also contains Modbus call-back functions implementation.

The ``module_modbus_tcp`` has an in-built Ethernet and TCP Server components. It uses the ``sc_ethernet`` and ``sc_xtcp`` xSOFTip to receive Modbus commands over TCP.

Try connecting the coils and registers to show other values. For example, a Read register command from Modbus Master should always read a specific address from the memory.

