From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Should battery generate events?
Date: Tue, 5 Oct 2004 23:20:22 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0410052308181.5157@frog.athome>
References: <20041004232557.6c342288@commensaal.drs.p>
 <Pine.LNX.4.60.0410051614420.3936@frog.athome> <20041005204929.647d25c9@commensaal.drs.p>
Reply-To: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041005204929.647d25c9-7SZEXzPdWeU90gtriz95AQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Tim,
On Tue, 5 Oct 2004, Tim Dijkstra wrote:
> On Tue, 5 Oct 2004 16:25:58 +0200 (CEST)
> liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
>> But do you allways run X (i.e. a graphical desktop)? ...because most
>> monitoring applications are graphics driven: There are some solutions
>> that come with KDE and I had a look (some time ago) at kacpi...
>> One problem might be, that your DSDT does not calculate a "present
>> rate".
>
> It does show the correct state while discharging, so that's not the
> problem.
Sorry, but I doubt that, or you do not have the latest BIOS - and the 
introduced this later. The DSDT from r01c0O-BIOS for TM 63x does allways 
say, that the "present-rate" is unknown.
But that does not mean, that there is no solution for you - just that you 
might run into problems, with other's solution, that depend on a defined 
present-rate

> I just wouldn't want to depend on an gui. Several people can
> use this machine, and I do not want to configure their desktops and hope
> they keep it like that.
ok. that would be a cleaner solution. But if you like to nag them, when 
the state drops to "warning", you might want to popup an xterm or other 
x-window. To do that you need to steal the .Xauthority (cookie) from the 
one running the X-server; because root does not have access in a normal 
setup. Just as a hint.

>> If you do not use the proprietary Nvidia-X driver, swsusp2 worked for
>> me. But as the Nvidia-driver is so much faster, I am not able to do a
>> software-suspend too.
>
> I do use the nvidia drivers, but even without X running it won't suspend
> successfully. Did you do anything special to get it to work?
Sorry, it was a bit ago, when I last tried it. I took the swsusp2-patches 
and the latest 2.6-kernel.
If you do experiments with this, be sure to always do a "sync" right as 
the last command, before you try to susupend. This increases the 
likeliness, that the fsck (in case it crashed) to fix it automatically 
without you loosing data. But I said "likeliness". Hope you got the tune 
with this.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBYxAf9bBoTzOf1pMRAk/AAJ93GLK0QKd4SdccQ1GnQpb/tN1XFwCg7l8G
9OTMFduJAgmm4ElEEwDZuDM=
=I2jH
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
