From: "Michael Frank" <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 13:40:52 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opr5poqe0z4evsfm@smtp.pacific.net.th>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com> <20040330233155.463A.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040330233155.463A.COUNT0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Mar 2004 23:51:17 -0500, Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org> wrot=
e:

> There are 3 competing implementations of S3/S4. None of them work with
> recent AGP ATI Mobility Radeons using ATI's drivers (the most popular
> current video chipset for notebooks / the only driver set that supports
> them properly in X). None of them work with hyperthreaded CPUs or SMP
> (again, hardly exotic). Most USB, Ethernet and other drivers are
> incompatible with S3/S4. The resume code is poorly tested, has race
> conditions, doesn't enable/disable interrupts at the right junctures,
> fails to restore PCI state and does nothing for AGP, USB etc. (left to
> drivers that could care less about suspend/resume).
>
> I was intent on getting my AGP ATI Radeon/P4 HT/SiS chipset notebook
> working by hacking the code. BUT suspend/resume issues are in ACPI code=
,
> in power mgmt code, in driver code, in AGP code, in suspend/resume code=
.
> All owned by different people. Many with competing implementations.
> No-one is a clear leader. The resume itself is near-impossible to debug
> since nothing is alive at that point and the video chipset isn't up.
>
> Many many people have the problem you describe (lockup on S3 resume,
> need hard power cycle to restart). I have it, and have seen numerous
> other people post on it all with dramatically different hardware. Only
> common factors is that the hardware is recent (i.e. AGP video, typicall=
y
> Mobility Radeon), and IT DOESN'T WORK.
>
> The situation can't be helped by the hacker looking to contribute by
> getting his own gear working (a massive consolidation, refactoring and
> cleanup is required by someone with in-depth knowledge of both ACPI and
> PC hardware). There are also probably deep implications for the Linux
> x86 driver architecture to doing it "properly". Linux vendors put almos=
t
> no effort into supporting laptop hardware despite growing laptop adopti=
on
> in replacement of desktops since their strategy is to get Linux to the
> point that the hardware vendors themselves are compelled to do such wor=
k
> like they do for MS Windows. laptop-specific issues such as this receiv=
e
> short shrift.
>
> In short, it's a hopeless mess, no-one who could solve this problem
> really cares about it enough to commission the team required, and it
> requires a huge effort by a couple of gurus with buy-in from Linus & co=
.
> for the kernel consequences to really fix this.
>
> Not happening any time soon. Optimize your boot to make it fast instead
> by fooling around with /etc/init.d and company. S3/S4? Bah. -Hu

Nice writeup!, including the fact that it is too big for joe-helpout and =
that a
team to handle the issues is lacking.

Most PM issues are out of scope of ACPI CA.

However I like to add that ACPI CA should implement a PM interface  for
ACPI  components to suspend/resume properly. Right now even AC adapter
must be made a module and reloaded after resume.

Michael


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
