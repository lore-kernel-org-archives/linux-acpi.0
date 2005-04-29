From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: Suspend2ram on Toshiba Tecra A3 OR problem with S3
	on new 915PM chipset system appears to be with SATA/IDE
Date: Fri, 29 Apr 2005 16:57:16 +1000
Message-ID: <1114757836.10883.9.camel@desktop.cunningham.myip.net.au>
References: <200504272244.j3RMibEf032018@fnapcf.fnal.gov>
	 <20050429023842.4d927bdf@Wierszokleta.pl>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050429023842.4d927bdf-c4cg+czvUqh2dnOJU1uSgA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tomasz Kojm <tkojm-Vl9ZkupcxcOsTnJN9+BGXg@public.gmane.org>
Cc: ron_-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ron-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ron-13hema8v3vg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.

On Fri, 2005-04-29 at 10:38, Tomasz Kojm wrote:
> In my case the video (integrated Intel 915GM graphic chipset) never 
> resumes correctly. However, I've noticed very similar issues with the
> disk. Sometimes the hdd led is always on after resume, sometimes not.
> With the old SATA/IDE driver the disk seems to perform some operations
> but at the end the system crashes totally and even the caps lock doesn't
> work.
> 
> As an open-source developer I know from autopsy how much such e-mail are
> frustrating to the developers. However it's impossible to me to prepare
> a valuable bug report on bugzilla - at the moment I see no way to
> reenable the LCD after resume (no acpi_sleep flag works on this system)
> and the system crashes every time eliminating remote access to a
> console.

Have you tried the various tools to post your video bios after resuming?
In my case, I needed to use both video_post and vbetool vbestate restore
to get a working configuration (and even then, it's not perfectly
reliable yet - I'm running XFree86 4.3, and have been told it's better
with Xorg. This is an i830, by the way.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
