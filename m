From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Tue, 6 Aug 2002 09:29:38 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020806152942.22987.qmail@scrye.com>
References: <200208010551.BAA23125@biohazard-cafe.mit.edu>
	<20020803220614.21895.qmail@scrye.com>
	<1028528792.7332.14.camel@anodyne.mandal>
	<20020805150428.10039.qmail@scrye.com>
	<1028614416.4553.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1028614416.4553.3.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Sourav K. Mandal" <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Sourav" == Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org> writes:

Sourav> On Mon, 2002-08-05 at 11:04, Kevin Fenzi wrote:
>> it stores and restores them ok, but I cant change them once linux
>> is up and running. LIke the buttons stop doing anything. ;(

Sourav> Yeah, trying it out myself it seems like a DRI thing.  Try
Sourav> turning off DRI in your XF86Config and see if it helps. You
Sourav> might have to reboot ... DRI doesn't work when coming back
Sourav> from suspend, and some things don't work once you run DRI.
Sourav> For me, once I run DRI the backlight refuses to turn off on
Sourav> lid close -- reboot fixes this.

humm... interesting... 

Sourav> If that doesn't work, try switching to a text console.

buttons still don't work in a text console either. 
I might try with no DRI after a bit... enjoying the stability for a
few days. 

For the backlight I rescovered: 

http://fdd.com/software/radeon/

Tool to turn on/off the backlight. I set it up in acpid to turn off
the backlight when the lid closes and back on when the lid opens (as
long as it doesn't get out of sync). 

Sourav> I have yet to apply Charl's patch, and so I alternate between
Sourav> DRI and no-DRI XF86Configs.  I don't know if the patch fixes
Sourav> the backlight thing ...

I am running that patched radeon, and I can't do anything with
brightness or the external monitor. Might be something else in my
setup tho. 

Sourav> Sourav

kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9T+tl3imCezTjY0ERAuwOAJ9cHeybDYhG2N9zoDgZh1sbjzr1HACggW+1
yQPEZCyXoNjxQ4+I5A3Wt/s=
=wYcn
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
