From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI suspend weirdness on Dell Inspiron 2650
Date: Tue, 11 Feb 2003 12:53:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211115332.GJ25625@poup.poupinou.org>
References: <3E491E11.20001@ihug.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E491E11.20001-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luke Hammer <lukeh-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 11, 2003 at 04:00:17PM +0000, Luke Hammer wrote:
> Hi,
> 
> I've finallyjust managed to get some kind of suspend state
> working on my Dell Inspiron 2650 laptop, using the 2.4.21-pre3 kernel
> and the ACPI-20030125-2.4.21-pre3 patch (under RedHat 7.3). I can
> get some kind of suspend state working using 'echo 1 >/proc/acpi/sleep'
> but I don't think it's the genuine suspend-to-RAM state. For one

Correct.  It is 'system standby'.

> thing, as soon as I put it into this state, one of the fans comes on
> and stays on (not very good when you're trying to conserve battery
> juice, but this is probably a Dell BIOS problem); and secondly, the screen
> doesn't actually seem to be turned off - I can still make out an image 
> on it,

How?  Could you explain ?  If yes, then there is a problem.  The
processor is supposed to have stopped execution.

> it just looks like the backlighting has been turned off.

It sound like, but definitely you should some power saving in
this state.  It is not the best, though, and S3 is really preferable.

> 
> Nothing at all seems to happen if I try to echo 3, 4, 4b or 5 to 
> /proc/acpi/sleep,

'3' is disabled explicitely.  It is in active developpement in 2.5.
'4' is not supported.  Actually it is defaulted to '4b'.
    You have to get swsusp (or a 2.5 tree) to get it.
'4b' is still under developpement for 2.4.  For example, nothing is
     done yet to restore a fbconsole (especially the svga one).  It
     is certainly not SMP safe, not to mention that  it can not be preempted.


> which is strange since the ChangeLog for the latest ACPI patch mentions
> being able to change settings for the S3 suspend,

Actually this is only for 2.5.  Perhaps a miss here (I have not read carrefully
the ChangeLog, sorry)

> and it also claims to
> incorporate the s4bios patch. If I cat /proc/acpi/sleep I get "S0 S1 S3 

But only for 2.4.

> S4 S5", so

You should have 'S4bios' if you cat /proc/acpi/sleep.  It is
somehow different from S4.  Remember, S4bios
work _only_ if your bios support it.  If not, I can not do so much for
you.  Please note also that S4bios is _not_ apm suspend-to-disk, so
your laptop can support the apm one, but not S4bios (even though it
sound like strange in my point of view)...

> I'm not sure if I'm doing something wrong, or if ACPI suspend-to-RAM support
> isn't fully functional yet.

S3 would not backported to 2.4.  I don't say this is not
possible, though, but sound like nobody will try to go for 2.4.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
