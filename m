From: Avuton Olrich <avuton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Problem suspending ASUS A7V8X based desktop
Date: Sun, 7 Aug 2005 00:31:41 -0700
Message-ID: <3aa654a405080700312aa756ff@mail.gmail.com>
References: <20050807062525.GA17750@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050807062525.GA17750-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 8/6/05, Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org> wrote:
...blah blah blah...
>   I have a desktop machine based on ASUS A7V8X motherboard. This one exhi=
bits
> strange behaviour when trying to suspend either to RAM or to DISK: Immedi=
ately
> after writing an activation entry to /proc/acpi/sleep, the system seems t=
o
> perform a kind of "periphery reset" - the screen goes blank (stops genera=
ting
> video, the monitor shuts itself down), hard disks stop etc. After a short=
 while,
> hard disk starts (probably the one necessary for writting the swap in the=
 case
> of STD), but the video card remains dead. The system then enters the requ=
ired
> suspend state.
>   The problems start after resuming: For example, when resuming from STD,=
 all
> goes well, I can see how the swap image is loaded, interrupts restored et=
c.,
> but immediately before the end of resume, screen blanks again and remains=
 dead.
> There is no way to restore it (including switching between X and text con=
sole).
> I think that it somewhat remembers its incorrect state into which it's pu=
t
> at the beginning of the suspend and returns to it.
>   With STR, there is even a BIOS feature to run VGA BIOS on resume, so
> no s3_bios is necessary in Linux, but after a very short period of displa=
y
> activity it is lost too.
>   Video card used:
> 01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 56=
00] (rev a1)
> operated with Nvidia driver (build 7667). This drivers seems to be PM-awa=
re.
> Happens identically on all the recent kernels including 2.6.13-rc5.
>   Any ideas ?
>                        With regards, Pavel Troller
>=20

http://bugzilla.kernel.org/show_bug.cgi?id=3D4723

I have had similar problems, standby works, but not S3, and don't
honestly care too much about disk :). I just hope S3 works one day. My
bug was pretty verbose so you should see the similarities if you check
it out.

Also, I have been getting this message in my dmesg in the latest kernels:
acpi_bus-0212 [02] acpi_bus_set_power    : Device is not power manageable

I tried asking how I could find out which device this is but I got no
answer to the mailing list.

avuton
--=20
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
