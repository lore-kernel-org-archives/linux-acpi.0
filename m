From: elbg <elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Acpica problem and explanations !
Date: Mon, 30 Jun 2003 18:34:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F0066B0.90101@laposte.net>
Reply-To: elbg-QFKgK+z4sOrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,
Can be that I badly understood ?

- ACPICA is a product INTEL for the support of the ACPI ?
- I must delete a ACPI drivers in " /usr/src/kernel-souce/drivers/acpi/ 
" well to be able to use in place ACPICA ?
- But or must I put it this ACPICA ?
- I also put the ASLCompiler " IASL " in the directory 
"/usr/src/acpica-unix-20030619/compiler/"
- When I launch MAKE in "/usr/src/acpica-unix-20030619/compiler/" I have 
this message :
" bison -v -d -y -pAslCompiler aslcompiler.y "
" aslcompiler.y:190.12-41: type redeclaration for 
PARSEOP_ACCESSATTRIB_WORLD_CALL "
" make: *** [aslcompilerparse.c] Error 1 "

I'm doing something wrong  ?
Thank,







-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
