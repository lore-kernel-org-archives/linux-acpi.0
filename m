From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: acpi functionality?
Date: Mon, 22 Dec 2003 14:25:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031222122521.GA15251@luna.mooo.com>
References: <200312212156.21261.vherried@insight.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200312212156.21261.vherried-rEckef8uG3NTGrOy2lmfZw@public.gmane.org>
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

On Sun, Dec 21, 2003 at 09:56:21PM -0500, Vince Herried wrote:
> Dell Lattitude C810 running RedHat 9...
> 
> this laptop has a Fn key and several functions with holding Fn and then 
> pressing another key.  Under acpi they don't seem to work (not in linux or 
> w2k).
> 
> I hardly ever run Win 2k and didn't notice it till recently.
> I assume this is a dell bug?  and will likely never be fixed.
> 
> stuff like
> 
> Fn Z 	-	shuts off the fans (which come on when resuming from a suspend even if 
> the box is cold).
> 
> Fn D	-	turns off the display.  Hum, this would be nice to have working.
> 	either my bios setting or RedHat shut the display off while I was building a 
> nother try at 2.6.0  and I couldn't get it to turn back on.   Sigh.  
> 
> Fn and function keys to go to setup, display battery charge ....
> 
> 
> I'm guessing I'm gonna have to disable acpi b4 these are gonna work, right?
> 

Check if they work with apm, if so, check the manufacturer's site about
a bios upgrade (either for acpi or for win2k).
A friend of mine has a HP omnibook which comes with an acpi bios. I
upgraded his laptop to win2k from win98 and several features stopped working
until I read the upgrade documentation and it appears they released a
bios upgrade for win2k which actually replaces the apm bios with an acpi
bios. Maybe dell did the same.
Otherwise you can also try the acme program. Its designed to handle
multimedia keys and on my sony it catches some keys that both acpi and
X don't seem to hear. (There are several others also, but they don't
work for me, depends on you keyboard).

>
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
