From: "Nick Bartos" <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org>
Subject: Re: acpi=force safe?
Date: Fri, 6 Feb 2004 15:49:12 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40747.65.164.3.3.1076104152.squirrel@mail.diamondcpu.com>
References: <3ACA40606221794F80A5670F0AF15F8401CBB685@PDSMSX403.ccr.corp.intel.com>
    <16644.65.164.3.3.1076087775.squirrel@mail.diamondcpu.com>
    <20040206211334.GH13262@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040206211334.GH13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

>
> Why not let user decide at boot time?  That easy to do so with syslinux
> for example.

I do use syslinux, but these boxes are supposed to be shrink rapped
solutions for customers where the user really just uses the web interface
(and some of the boxes are headless), so having the user modify boot parm=
s
really isn't possible.  Also, the entire distro is based on a single
config and upgrading overrites the bootloader config, so setting user
defined defaults really wouldn't work.

As long as there aren't any changes in the linux acpi implementation that
make a board stop working on an upgrade (obviously it will be tested on
the inital install), then it should be fine.  How probable is it for that
to happen?  If the hardware is unchanged I would hope that updating the
kernel (with acpi=3Dforce) wouldn't prevent the system from booting.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
