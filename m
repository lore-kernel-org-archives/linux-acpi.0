From: Stefan Lutz <Operating-Systems-Team1-/ixSogHR0HOS/tZ4Wjpou0EOCMrvLtNR@public.gmane.org>
Subject: Re: SBST support
Date: Thu, 3 Jun 2004 14:56:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406031456.44195.Operating-Systems-Team1@fujitsu-siemens.com>
References: <20040603123451.GA3689@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040603123451.GA3689-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 03 June 2004 14:34, Pavel Machek wrote:
> Hi!
>
> I was asked to do SBST support for Linux. What is strange that all
> info except "design capacity critical" can be read from _BIF, linux
> does that and it seems to work.
>
> Is SBST some kind of legacy table? Should it be supported? What if
> it returns different value from _BIF?
>
> 								Pavel

Excerpt from APCI 2.0 Spec:
-----------------------------

"If the platform supports batteries as defined by the Smart Battery 
Specification 1.0 or 1.1, then an Smart Battery Table (SBST) is 
present. [...] OSPM uses these tables with the capabilities of the 
batteries to determine the different trip points."

As far as i understand this, it is no legacy table, but one many 
tables inside the ACPI subsystem.

Hope this helped,

Stefan

-- 
Stefan Lutz
Fujitsu Siemens
Augsburg GERMANY


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
