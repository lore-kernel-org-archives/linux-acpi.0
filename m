From: siva <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Subject: ACPI support for add-on devices driver
Date: Thu, 06 Feb 2003 10:46:19 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E41EFA3.8060406@wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-9a1732af-0aff-45ab-b6cf-43fc6ad5dbc2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-9a1732af-0aff-45ab-b6cf-43fc6ad5dbc2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I like know what I need to do if I want to have ACPI power management 
support in my driver for an add-on device. When I am browsing APM 
implementation, I found that Linux kernel have general PM Interfaces 
like pm_regsiter and pm_unregsiter. In APM driver, pm_send is being 
called to send notification to all registered add-on devices.

In the case of ACPI, we have Device power state D0,D1,D2,D3. I like to 
know how the interface between the ACPI driver, PM interface and ADD-ON Driver happens.
Can any one please send me some details about it?

Thanks,
Siva







------=_NextPartTM-000-9a1732af-0aff-45ab-b6cf-43fc6ad5dbc2
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************




------=_NextPartTM-000-9a1732af-0aff-45ab-b6cf-43fc6ad5dbc2--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
