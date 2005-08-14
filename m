From: Antonio Distante <antonio.distante-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: S4 and radeon dri
Date: Sun, 14 Aug 2005 17:16:58 +0200
Message-ID: <1124032619.10075.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all!
 
I have some problems with suspend to disk (S4) and X:
 
 Notebook: 	Compaq Presario 2532EA
 Graphic card:	Radeon IGP345m [RS200]
 linux kernel:	2.6.XX latest
 Distribution:	Ubuntu Breezy/Hoary
 X:		Xorg 6.8.2

Suspend goes well, after resume I get a messed up screen and the laptop
freezes:
 * no entry in the log files
 * no ssh/network working
>From console or with DRI disabled I can suspend/resume laptop without
problems.
Is this an ACPI related problem? I think so because swsusp2 works well
even with DRI enabled.
How can I debug this to give you useful information?
Thanks,
Antonio 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
