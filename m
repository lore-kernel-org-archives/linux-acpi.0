From: John-otv8KCb+Bkdaa/9Udqfwiw@public.gmane.org
Subject: Re: "bypass" ?
Date: Fri, 24 Jan 2003 12:34:45 +0000 (GMT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E18c33O-000Pb7-00@probity.mcc.ac.uk>
References: <3E3018DA.7000505@gkec.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E3018DA.7000505-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org
Cc: John-otv8KCb+Bkdaa/9Udqfwiw@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 23 Jan, Stefan Behnel wrote:
..
>> I have a Toshiba 3000-400 laptop, which previously needed a ACPI table
>> bypass for it to detect the battery power levels, which I have been
>> doing up to 2.4.17..
> 
> What do you mean, a "bypass"?

With the standard kernels (upto around 2.4.18) the batteries would show
up under ACPI but no power level details were indicated.  I followed the
instructions on an Intel web site (forgot the link) which outlined the
process of dumping the DSDT, dissasembling it, correcting the mistakes
in the schema, reassembling the schema as a hex dump which is then
included into /usr/src/linux/drivers/acpi/tables/tbget.c.

This may not be the ideal solution, but it did work (sort of) and the
modified ACPI did display battery power levels etc.

None of this was required with 2.4.20 and 20030109 patches.

John 
-- 
  John Heaton, G1YYH
  Manchester Computing, Kilburn Building.
  The University of Manchester, Oxford Road, Manchester, England, M13-9PL
  pstn://+44-161-275-6011/Hello/Is.Dat-U?
  fax://+44-161-275-6040/screech/warble/ssshhh/beepbeep





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
