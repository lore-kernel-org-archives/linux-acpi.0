From: Oeystein Olsen <oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Subject: Acpi on compaq evo N1000v
Date: Fri, 9 May 2003 11:47:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305091147.15007.oystein.olsen@astro.uio.no>
Reply-To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(I got a suggestion to send this one to acpi-devel instead of acpi-support)


Hello all,

My laptop seems to be working reasonable well with my laptop now. I've 
followed the How-Tos and tried to fix my original dsdt-table. Button-events 
are registered, fans work, it powers off at the end of the shutdown sequence, 
throttling works, the ac-adapter is correctly detected and info is passed to 
my acpi-deamon. I haven't tried S3 and S4 states yet.

The only big problem left is the battery. Unless I plug in the battery after I 
power up the laptop, I don't get battery status (discharge rates, remaining 
power etc) It's reported as absent, but I can run on battery power. 

I'm running kernel 2.4.20-rc1-ac4 (rc1 to rc1-ac3 didn't work for me with 
acpi). I've also applied the last patch to put my acpi_dsdt.aml into the 
initrd file. (thanks Markus Gaugusch!!)

When I run the iasl compiler I still get three warnings, of which two are 
related to batteries (See (1) below). I also get the following error at boot:

psparse-1121: *** Error: Method execution failed [\_SB_.C03B.C04E.C0CF.C0D3] 
(Node c185e728), AE_NOT_EXIST

Method execution failed [\_SB_.C03B.C04E.C0CF._INI] (Node c185b6a8), 
AE_NOT_EXIST

nsinit-0397 [06] ns_init_one_device    : \_SB_.C03B.C04E.C0CF._INI failed: 
AE_NOT_EXIST

 .........................................evrgnini-0261: *** Error: Could not 
install pci_config handler for C03B, AE_ALREADY_EXISTS



Does anybody have any suggestions on how to fix this error and the three 
warnings I get below? My dsdt-table is at

http://folk.uio.no/oeysteio/dsdt.dsl

and the messages I get at boot is located at:

http://folk.uio.no/oeysteio/messages

I've tried to fix the dsdt-table, but no success. Any help would be much 
appreciated.

---------------------------------------------------------------------------
(1)

dsdt_table> iasl -tc dsdt-Compaq_Evo_N1000v-0.005.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030228 [Feb 28 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt-Compaq_Evo_N1000v-0.005.dsl  1581:                 Method(_Q08) {
Warning  2019 -              Not all control paths return a value ^  (_Q08)

dsdt-Compaq_Evo_N1000v-0.005.dsl  1924:                         Method(_OFF) {
Warning  2019 -                      Not all control paths return a value ^  
(_OFF)

dsdt-Compaq_Evo_N1000v-0.005.dsl  2231:                         Method(_OFF) {
Warning  2019 -                      Not all control paths return a value ^  
(_OFF)

ASL Input:  dsdt-Compaq_Evo_N1000v-0.005.dsl - 3721 lines, 128505 bytes, 2957 
keywords
AML Output: acpi_dsdt.aml - 21534 bytes 750 named objects 2207 executable 
opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 793 Optimizations





-- 
Øystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
