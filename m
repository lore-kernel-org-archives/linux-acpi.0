From: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Subject: IBM Thinkpad R32 and ACPI
Date: Sat, 12 Apr 2003 17:33:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030412173357.1e4ea127.linux.wali@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi all,
since I've this fine new Thinkpad (Chrismas) I'm trying from time to time to get acpy running with linux. Ok the present state is the following:
- I've to run with the fixed ecdt-table.
- If I run 2.4.21-pre6-acpi i get these error-messages
  also mentioned before like: 
  ACPI-0341: *** Error: Handler for [SystemMemory] returned AE_BAD_PARAMETER
- If I do the hack with commenting out the 
  "if (ec_ecdt && ec_ecdt->uid == uid) {...}" block 
  in acpi_ec_add() of ec.c. Acpi will start without error messages and I'll
  get no more errors when I press a button, but the only buttons which
  will report actions in /proc/acpi/event are the lid button and the sllep 
  button (fn+F4). All other buttons (also the power-button) are "acpi-dead".
What to try now?? Any ideas?? Shoud I start fiddling around with the DST or should I try a 2.5.xx kernel?? 
Any help apreciated
regards
micha


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
