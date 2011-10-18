/*==============================================================================
Filename:
Project :
Author  :
Version :
Purpose
--------------------------------------------------------------------------------

Version History
--------------------------------------------------------------------------------

License
--------------------------------------------------------------------------------
Copyright (c) 2011, XMOS Ltd, All rights reserved
This software is freely distributable under a derivative of the University of 
Illinois/NCSA Open Source License posted in LICENSE.txt and at 
<http://github.xcore.com/>
==============================================================================*/

/*------------------------------------------------------------------------------
Include files
------------------------------------------------------------------------------*/
#include <xs1.h>
#include <print.h>
#include "xmodbus.h"
#include "modbus_tcp_server.h"
#include "xtcp_client.h"

/*------------------------------------------------------------------------------
Extern Variables
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Manifest constants
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Typedefs
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Global Variables
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Static Variables
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Prototypes
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Implementation
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Name:
Purpose:
Input:
Output:
Notes:
------------------------------------------------------------------------------*/
void xmodbus(chanend tcp_svr, chanend c_user)
{
   xtcp_connection_t conn;

   modbus_tcp_reset(tcp_svr);

   // Loop forever processing TCP events
   while(1)
   {
      select
      {
      case xtcp_event(tcp_svr, conn):
         modbus_tcp_handle_event(tcp_svr, conn);
         break;
      }
   }
}

/*============================================================================*/
