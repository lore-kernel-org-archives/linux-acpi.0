From: "Ralf-P. Weinmann" <ralf-HCprxmsOTPNg9hUCZPvPmw@public.gmane.org>
Subject: Re: laptop turns itself off
Date: Tue, 1 Oct 2002 12:06:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021001100651.GA6517@bender.fimaluka.org>
References: <20020927142320.GB2821@lps.ens.fr> <20020927154542.GH7904@poup.poupinou.org> <20020930155044.GA21015@lps.ens.fr> <20020930163324.GF25319@draal.physics.wisc.edu> <20020930215142.GA413@bender.fimaluka.org> <20020930234303.GA6392@bender.fimaluka.org> <20020930215142.GA413@bender.fimaluka.org> <20021001030010.GG25319@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021001030010.GG25319-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Cc: ?ric Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 30, 2002 at 10:00:11PM -0500, Bob McElrath wrote:
> [...]

> For reference, my Compal ACL00 is equivalent to a Toshiba 3000-514 (I
> believe, I could be wrong on the last 3 digits).  Compal manufactures
> these laptops for Toshiba.
> 
> Based on the available information, I agree with Ralf, this is a
> crappy-hardware problem.
> 
> We need to figure out which models of these laptops have this problem,
> and whether the problem is universal to all of them, or a hardware bug
> that can be fixed by swapping out the bad hardware (Ralf's experience
> would seem to indicate universality...).  Does anyone know of someone
> who has this laptop and does NOT have the turn-off/hang problem?  Bruno
> you have probably had the most contact with Toshiba 3k users...
> 
> Secondly, we should all pursue remedies though the vendors that sold us
> this crap.  I think a class action lawsuit would be appropriate, if they
> are not willing to replace the laptops with working models.
> Unfortunately, Compal appears to no longer be manufacturing this laptop.

I've got some more things you guys might want to look at. Googling for
'spontaneous shutdown' and similar terms, I found the HP business customer
discussion group, which contains quite an interesting thread about HP
Pavillions (ZT1130/ZT1145), the posting by a a Robert J. Koening being
especially insightful. See the following URL:

http://bizforums.itrc.hp.com/cm/QuestionAnswer/1,,0x3009237a4bc6d611abdb0090277a778c,00.html

To quote from it:

"[...] I summarize the substance of the one of the other threads I read.

 It was concluded by all that it was an overheating problem.

 People aimed small fans at their hp laptops and claimed to have remediated the
 problem.

 Others put tongue depressors under their laptops and removed piles a paper
 around the lap top  and claimed to have stopped the uninvited shutdowns by
 prompting better ventilation.

 But there was no compelling epiphany to explain the problem.

 However, I got the sense that the problem was more a false high-temperature
 reading than a real high-temperature problem.

 There was a lot of talk about whether the automatic fan was working when the
 intrusive shutdown occurred.

 The shut downs did not necessarily seem to take place when the fan was
 working.

 At the end of day, it was suggested by the hp overseer (who watches us writhe
 for a while before finally jumping in) that the new BIOS will cure the
 problem. [...]"

I'm not sure what ODM is supplying Hewlett-Packard for this machine, but as
we have learned before, some Omnibooks seem to be Compals as well so I would
not rule out the possibility that the Pavillion ZT11xx are as well. Maybe the
owner of one on this list can find out? I downloaded a BIOS image for it,
extracted and ran strings over the all.rom file, but it seems to look very
different, except for the Insyde signature on both of them.

Incidentially, Insyde Software seems to be providing ACPI firmware for ODMs
like Compal.  What a coincidence. See the following URL:

http://www.insydesw.com.tw/bios051002%20(%203-1).htm

Cheers,
Ralf

-- 
Ralf-P. Weinmann			HOME: r a l f @ f i m a l u k a . org
Student, Computer Science		 UNI:   r p w @ u n i . d e
Technical University of Darmstadt, Germany


-------------------------------------------------------
This sf.net email is sponsored by: DEDICATED SERVERS only $89!
Linux or FreeBSD, FREE setup, FAST network. Get your own server 
today at http://www.ServePath.com/indexfm.htm
