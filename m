From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: s3 on vaio z600
Date: Wed, 2 Apr 2003 13:33:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030402113318.GK10287@poup.poupinou.org>
References: <1048682112.501.11.camel@localhost> <20030328205923.GG5147@zaurus.ucw.cz> <1049065566.914.30.camel@localhost> <20030402085312.GA2582@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030402085312.GA2582-VNkyu7EogrqGmfs5Z0+9fw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 02, 2003 at 10:53:12AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Few leds on parallel port may do the trick... along with outb() in wakeup.S.
> > 
> > Ole Rohne told me to use lcall _0xffff, _0 in wakeup.S, which I did in
> > the first place and nothing happened. Since according to him this is
> > supposed to reboot the computer I concluded that there is either
> > something wrong with the wakeup-vector or with _WAK (there is no BFS in
> 
> _WAK is called *way* after wakeup.S.
> 
> Does VGA look like it is in text mode
> after resume? That would help. Otherwise
> get those leds...
> 
> Or you might be able to beep on pc
> speaker -- someone here had code
> to do that.

You have my code.  Feel free to post it.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
