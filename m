From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: No thermal information reported
Date: Fri, 14 Nov 2003 13:38:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031114123856.GJ32464@poupinou.org>
References: <Law9-F60bbSzNZb4UA200006fa3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Law9-F60bbSzNZb4UA200006fa3-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jim Sweet <js9204-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 14, 2003 at 10:10:09AM +0000, Jim Sweet wrote:
> Hi,
> 
> I'm posting this query to acpi-devel as I had no responses after posting to
> acpi-support a fortnight ago.

acpi-support is more or less obsolete, now.

> 
> I would be very grateful for some advice and/or assistance regarding ACPI
> and the 2.4.22 kernel. I am a unix kernel devloper by trade but have
> very limited experience with Linux internals, and none with ACPI. I have
> read all the HOWTOs, etc., that I could find, and I have looked through the
> list archives.
> 
> I have a new HP Pavilion A309uk desktop with a MicroStar MS-6577
> motherboard; it's OEM and neither MicroStar nor HP can/will provide me
> with a manual. When the PC powers on, the fan (I think it's the CPU fan
> rather than the PSU fan) is extremely loud. However, as soon as WinXP
> starts, the fan slows down and becomes quiet. Using a stock 2.4.22 kernel,
> the fan remains very loud.
> 
> My objective at the moment is to quieten the fan under Linux without
> exposing the CPU to the risk of overheating.
> 
> Although the BIOS (Award V6.00PG) has a menu that shows the CPU temperature
> and the fan speed, I have found no way in WinXP to get the same information;
> all I can do with regards to power management is to configure the effect of
> the power button (I should point out that I am a Windows novice). This leads
> me to wonder if on my motherboard any thermostatic control is hard wired,
> and that no thermal information is exported by the BIOS to the OS.
> 

...

> My question, then, is this: could it be that my motherboard/BIOS simply
> won't provide an interface for getting and setting thermal information, or
> is it instead that my kernel is not interpreting it correctly?
> 
> Any guidance, advice, pointers, etc. would be gratefully recieved. I've
> included below the output of 'dmesg', 'biosdecode' and
> 'acpitbl /proc/acpi/fadt'.

Ok, but there is a 'miss'.  Thermal stuff is in DSDT table.

acpidmp DSDT > dsdt
Install iasl from Intel site, then
iasl -d dsdt
You should have a dsdt.dsl.
Then if something like
grep ThermalZone dsdt.dsl
do not match, ACPI can't help you for your purpose (that is, controlling
thermal stuff related thinggy).

But (good news), if your BIOS report temperature, there is really good chance
that you have a chip like LM75, or LM78.  In such case, there is really
really good chance that lm-sensors, from http://secure.netroedge.com/~lm78/
work for you.

-- 
Ducrot Bruno
--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
