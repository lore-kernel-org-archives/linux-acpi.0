From: <HurryLin-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org>
Subject: RE: SuSE AMD x86-64 bits installation issue
Date: Wed, 12 Nov 2003 15:05:28 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6A7AB4426712514F9E2AB28C407285FA04EBB931@exchtp02.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, DreamKu-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, StephenChen-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, PearHuang-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, NormanChung-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, KenCho-6hSdJfI2Hxp9nmWX13WWKA@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear Len:
	I have filed a bug into http://bugzilla.kernel.org/. And I also =
attached files for your information.=20
	If you have any questions please let me know. Thanks !
Hurry

-----Original Message-----
From: Len Brown [mailto:len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
Sent: Saturday, November 08, 2003 3:02 AM
To: Andi Kleen
Cc: Hurry Lin; ACPI Developers; Dream Ku; Stephen Chen; Pear Huang;
Norman Chung; Ken Cho
Subject: Re: SuSE AMD x86-64 bits installation issue


On Fri, 2003-11-07 at 06:13, Andi Kleen wrote:

> The symptom is when IO-APIC is enabled the system does not boot and=20
> hangs early in some device driver like IDE. With IO-APIC disabled you =
obviously
> get a very different /proc/interrupts.

Ok, then the bug report needs to include the console output captured via
serial console.

Also, it may be useful to see what windows does on the same hardware.
If the bug report can include the IRQ info from "winmsd"
run on Win2K or WinXP, that may be helpful.

thanks,
-Len




-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
