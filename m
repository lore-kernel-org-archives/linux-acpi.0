From: "Breathnach, Proinnsias (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
Subject: RE: C2 or C3 on Presario 2110US?
Date: Thu, 13 Mar 2003 18:48:25 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <A3C83F41488BD61195C3000802252FC135C175@dubim07742.ie.ml.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
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
To: 'Carl Thompson' <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Cc: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Carl,
	I'm no ACPI expert here, but I'd imagine the problem is probably
closer related to the DSDT (the tables the BIOS manufacturer included to
tell the OS about what it can / can't do ...

In your case it seems that the manufacturer (of either the BIOS itself or
probably the laptop) didn't include any C-State information in the ACPI
tables, or if they did that this information is unreadable by the Linux ACPI
parser.

Can you output your DSDT and copy the list on it ... someone with more
experience may have an answer as to why it's failing like that !

What versions of the kernel / ACPI are you using are also important factors.

P

> -----Original Message-----
> Actually, any sort of
> acknowledgement would be nice.  What ever happened to the talk of
> implementing a bug tracking system?
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
