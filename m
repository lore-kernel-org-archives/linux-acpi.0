From: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Subject: Re: Asus ACPI Hotkeys
Date: Sat, 03 May 2003 14:53:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EB3BBCD.7050008@gkec.tu-darmstadt.de>
References: <20030503112602.3d2ac1c3.g.zwartjes@student.tue.nl>	<Pine.LNX.4.53.0305031214220.4945@tweety.gaugusch.at> <20030503123325.5246f48f.g.zwartjes@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030503123325.5246f48f.g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Gertjan wrote:
>>Do they generate an event, when you do
>>cat /proc/acpi/event
>>and press a button?
> 
> Only sleep and poweroff. But that's only 2 out of 10.

I'm a little surprised, can you positively confirm that the buttons generate ACPI interrupts?

try
fgrep acpi /proc/interrupts
and see if the number of interrupts increases whenever you press a button.

Then you're sure that the buttons really run over ACPI. Believe me, not much of what I've seen so far did use ACPI for buttons other than the sleep and power button ...

Stefan



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
