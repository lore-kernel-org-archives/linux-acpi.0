From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: D600 + S3 Sleep
Date: Fri, 18 Mar 2005 15:03:10 +0100
Message-ID: <20050318140309.GA18696@message-id.gmane0305.slipkontur.de>
References: <1111137292.23665.5.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111137292.23665.5.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 18, 2005 at 05:14:52PM +0800, Ow Mun Heng wrote:
> Hi All,
> 
> 	Anyone here managed to get S3 to work on the D600?


yes.
> 
> I'm on 2.6.11 kernel and still the same Black Screen after resume
> persists.

I am using "vga=normal", the X-Server restores the backlight for me.
(it also works well with vbetool restore IIRC, but i did not test the
last few weeks).

seife@strolchi:~> uname -a
Linux strolchi 2.6.11.4-4-default #1 Wed Mar 16 21:34:20 UTC 2005 i686 i686 i386 GNU/Linux
eife@strolchi:~> X -version

X Window System Version 6.8.2
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: SuSE Linux [ELF] SuSE
Current Operating System: Linux strolchi 2.6.11.4-4-default #1 Wed Mar 16 21:34:20 UTC 2005 i686
Build Date: 16 March 2005
        Before reporting problems, check http://wiki.X.Org
        to make sure that you have the latest version.
Module Loader present
seife@strolchi:~> lspci|grep VGA
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [FireGL 9000] (rev 02)

This is the upcoming SUSE 9.3 configuration. Works for me since at least 
8 Weeks (always tracking the latest kernel and using pretty latest X.org)
 
> I've tried Software Suspend 2 and By golly, it's much faster then SW1.

Well swsusp is also fast for me, but i have never compared it to swsusp2.
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
