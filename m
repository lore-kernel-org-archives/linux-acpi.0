From: =?unknown-8bit?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: Re: Shuttle SB61G2 fan speed
Date: Thu, 9 Oct 2003 22:10:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031009201039.GA30269@lps.ens.fr>
References: <E1A73Nv-0001M5-68@cell01.cell01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1A73Nv-0001M5-68-6vcCkRnH9/iXl4vLVl4uKAC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Eric Northup <digitale-eFwX6J65rk/J8bqQQ1YlwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I have a SB51G, which should be very similar to your shuttle.

In my case, ACPI module does not change the fan speed, but loading the
lm_sensors kernel module (i2c) does. The reason is that the modules
writers, as they don't have all the specs they need, find it safer to
reinitialize the whole sensors.

Do you have the sensors loaded or compiled in ? If this is actually the
cause of the problem, and if you really want sensors in your kernel,
removing the reinitialization is really a one-liner.

=C9ric Brunet
On Tue, Oct 07, 2003 at 09:45:03PM -0400, Eric Northup wrote:
> I have a Shuttle mini-PC currently running linux 2.6-test6 (but I have
> seen this issue w/all kernels I've tried, 2.4.x and 2.5.x).  It has a
> "smart" fan control, which regulates the speed of the system fan
> according to the temperature (a Thermal Zone in ACPI terms, yes?).  The
> problem is: as soon as Linux gets control from GRUB, the fan goes to
> full speed and stays there.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
