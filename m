From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 18:08:37 +0100
Message-ID: <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42121EC5.8000004-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
> To suspend and resume properly, call the following script as root:

Success.=20

After deactivating DRI in the X config file and saving the states with
your script (thanks) and turning off various stuff I get X running
again.

Questions:
- DRI must be disabled I guess?! Even with newer X server (x.org)?
- I dont have to restore the font, it is back without any problem
  (I have vga console)
- Sometimes I have to make a Sysrq-s (sync) to get some stuff running
  (eg logging in from the console hangs after input of passwd, calling
  sysrq-s makes it continue). I had a similar effect when logging in
  AFTER resuming (for the resume I had only gdm running but wasn't
  logged in) the GNOME starting screen stayed there indefinitely, no
  change. Even after restarting the X server and retrying.
  Logging in with twm session DID work without any problem.
  Do you have any idea what this could be?
- My script is a bit more complicated: stopping: hotplug, mysql,
  ifplugd, waproamd, cpufreqd, acpid, ifdown eth0, eth1, rmmod acerhk
  echo "performance" onto governor, then going to sleepand doing
  more or less the reverse stuff after waking up.
  DO you have any experience with hotplug network etc stuff, working
  even without stopping?

Thanks a lot.

Best wishes

Norbert

-------------------------------------------------------------------------=
------
Norbert Preining <preining AT logic DOT at>                 Universit=E0 =
di Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) 59966-=
690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C=
5 B094
-------------------------------------------------------------------------=
------
CROMARTY (n.)
The brittle sludge which clings to the top of ketchup bottles and
plastic tomatoes in nasty cafes.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
