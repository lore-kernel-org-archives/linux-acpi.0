From: Francis Yom <fyom-NeBS1MF9zuBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Compaq Presario 2700 with memory overheating issues - aftermath
Date: 11 Nov 2002 19:24:44 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037060685.1458.68.camel@sera.symmetry.symmsys.com>
References: <1036996001.1459.9.camel@sera.symmetry.symmsys.com>
	<20021111222553.GA495@yggdras.agere.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BRx8vtvwHOxmp04Ty2uf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021111222553.GA495-OCtGrgxsRvDJaGQldrLmRgC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jocelyn Jaubert <jaubert-6bugY6I12JBBDgjK7y7TUQ@public.gmane.org>
Cc: dclug-Xml+yC1NCBs@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dc-sage-ZjEY3O3j2HlAfugRpC6u6w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-BRx8vtvwHOxmp04Ty2uf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tuxers, ACPI-DEV, and to Jocelyn on the ACPI linux dev list who I am
responding to but the info contained may be interesting to all:

I have tried using just 1 512 sodimm, and I have even tried using a
another person's single compaq's 512 sodimm.  In both cases, I get some
relief but the problem is still evidently there - screen flickers

I really need a full gig as I run vmware with multiple os sessions.  I
really do use ALL the memory :-o

I eventually got a compaq tech to admit that the compaq 2700's have a
problem with heat when you max out the amount of memory they can have
and you are using the 32 meg chip for video, although they still refuse
to do anything about this problem :(

I have found a low-tech solution to this problem....  I've created a
'heat transfer plate' by purchasing a non-stick metal cookie pan like
the image attached.  Placing the laptop on the pan WITHOUT the feet
propped allows the heat from the base of the laptop to flow out through
the cookie pan.  The cookie pan gets warm, but the laptop bottom is a
lot cooler because the pan spreads the heat out. ;-)  I should have been
a Compaq engineer ;-)  The pan cost me $6.  I do have to pat myself for
this solution.  I got the idea when I saw a friend defrosting a frozen
chicken by putting it on top of an upside down saute pan - the saute pan
pulled the cold away from the bird making it defrost quicker - wow.  I'd
credit school but I almost failed thermodynamics so I switched to an
I.S. major instead. <Shrug>

Regarding ACPI on the presario 2700, I have battery status and thermal
zones! :-)  To do this, I backported the 20021101 acpi patch back to the
2.4.19 kernel, AND I upgraded the bios of this laptop to the latest F.12
version.  The previous versions were buggy, and I suspect you are not
using the latest bios version for your laptop.  To do this, you must
have the intelligence and skill of a person running linux for a long
time (4 years - more if you include prior unix work) and the insight to
get a cheap cookie pan. <g>

A warning - you cannot install the newer bios unless you run windows xp
or 2k.  The bios flashing program ONLY RUNS IN WINDOWS - IT IS NO LONGER
ON A BOOT FLOPPY.  I run entirely on linux (Debian) and I'm damn proud
of it.  It was a f*cking pain in the ass to backup, install xp, flash,
and then restore my backup.  Please be aware of this.

Best wishes!
Francis


On Mon, 2002-11-11 at 17:25, Jocelyn Jaubert wrote:
> On 2002.11.11 01:26 Francis Yom wrote:
> > I am having some concerns with Compaq (now HP) with my Presario 2700.
> > 
> > I recently up'ed the memory to 1024 mb from 128 that came from the
> > factory.  I got the 2 x 512 mb sodimms from Crucial memory.
> > 
> > Since doing this, in an environment where the room temperature is
> > above
> > 70'F and if I don't prop the laptop feet, the screen will begin to
> > flicker after about 30 minutes of use.
> 
> Hi,
> 
> I have a Compaq 2800 myself, but no problem like yours. I have 256 Mo 
> of memory, coming from Compaq, and I haven't upgraded it.
> 
> Did you try to put only one 512 Mo dimm ? It should help you to see if 
> the brand is really the cause of your problem.
> 
> Concerning ACPI, do you have battery information ? I don't have any 
> /proc/acpi/battery on my laptop, with kernel 2.4.19 patched.
> 
> 
> Thanks, Jocelyn Jaubert


--=-BRx8vtvwHOxmp04Ty2uf
Content-Disposition: attachment; filename=10x15cookie_bake.jpg
Content-Type: image/jpeg; name=10x15cookie_bake.jpg
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAPAAA/+4AJkFkb2JlAGTAAAAAAQMA
FQQDBgoNAAAH8gAADAcAABMMAAActP/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggLDAoKCwoKDBAM
DAwMDAwQDA4PEA8ODBMTFBQTExwbGxscHx8fHx8fHx8fHwEHBwcNDA0YEBAYGhURFRofHx8fHx8f
Hx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8f/8IAEQgAlgBsAwERAAIR
AQMRAf/EANUAAAEEAwEAAAAAAAAAAAAAAAUDBAYHAAECCAEAAwEBAQAAAAAAAAAAAAAAAAECAwQF
EAABAwMDAwEIAgMBAAAAAAABAAIDERIEEAUGIDETITBBIiMzFCQWQBU0JTUmEQABAgIFBwoFAwUB
AAAAAAABAAIRAyExQVESEGGBwSIyE3GRobHRQmIjMwThUnKCkqKyYyAw8OIUwhIAAwEAAAAAAAAA
AAAAAAAAQHCAMRMBAAICAQMDBQEBAQEAAAAAAQARITFBEFFhcYGRIKGxwdHwMPHh/9oADAMBAAIR
AxEAAAGxhAGkAQBAEhIsRBEGwJBKk56qwKNchI6O1eyU2nKaosePK3UTVTY7c3oZGBRDGePYjfK5
MnEbvY7DD5RizHXsMuNOG95+jppUKMY2x6mzezE9Ms6biNT8CbUfquXIHflv9MgOkWhmPf3NHpgm
Z60y5z02qJPNII1bifRy3tNHR0u0O5vSKLHu8jSZR5wTSUJuRZ6YKK658NWtcStOm2mfJ6Dm845t
yy7DcoLtyJBuUH0y6V9BYOuE2VU85W5ut+TG6ljVLESfOjAD5uOu3SlhrnLNuexFVRVEPVFsOpzL
a3Cickysk8wxUR6MZTzdQzXE9vzWiqqioiE6opHsOoRtzaGUzslDjmo5jRzG+X55HpyuCbq2oiuf
UzJb3jgjWG6pQrXCV475O8T25dVkbubtm6yqIph2u3kIq9Js9eTpHQ5Flr21G9Mnyty4vVVXDiHY
9sxnETQNpsKQ+o2J4TIAlMsVn0QrbH0ElXrmGZdduacijQ2dGipMaSfYSXTBUUXjeq6n0MTBHMDz
6ri05MBir0NRGmtsdEriDzrUDq9DKMtVzn1XPfKiGgWYtDTZlLoNA0m6YNLjeLFqrI6bpfO1HtCB
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

--=-BRx8vtvwHOxmp04Ty2uf--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
