From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: VGA patch by Bruno Ducrot -- no success yet (includes
 request to our Intel people)
Date: Fri, 13 Feb 2004 11:13:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3ptcj2spf.fsf_-_@reason.gnu-hamburg>
References: <m3u11wnflb.fsf@reason.gnu-hamburg>
	<20040212223706.GA13262@poupinou.org>
	<m3r7wzx5kb.fsf@reason.gnu-hamburg>
	<20040212232230.GC13262@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040212232230.GC13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> (Bruno Ducrot's message
 of "Fri, 13 Feb 2004 00:22:30 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Fri, 13 Feb 2004 00:22:30 +0100
 || Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote: 

 >> Don't know whether/how this interacts with your code.

 bd> Well, then I really need to make one marked 'medium' of the TODO
 bd> list which read: - implement an interface so that external
 bd> modules can be made, like the asus, toshiba specifics.

 bd> At least for the asus case.

Well, maybe the acpi4asus people will feel inspired to help from the
other side of the code -- the current problem affects all ASUS M2N and
M3N, it seems.

Since they are quite popular models, it would be in many people's
interest to bring this together soon.


Which makes me wonder. 

There is someone else I would expect to have some interest in seeing
support of the Intel 855GM chipset: Intel.

I know that a good part of the ACPI part was contributed by people
working at Intel, but I don't know whether this is secret, tolerated
or official. As I would gather it is probably not secret for you would
have used different email addresses then, is on of you on the problem?

I am not sure we actually know _why_ that particular chipset fails to
bring the display back to life after S3. 

Configuring it seems to be insufficient, un/reloading the driver
doesn't work -- the DRI/DRM driver doesn't actually *load*, the
command to load it just sits there forever. So there must be more to
be done? Maybe some secret wakeup signal?

There were people at Intel writing the proprietary graphics driver for
Linux, they should know at least part of the solution, if not all.

Could you see who did that driver and get in touch with them
internally to see whether they have an idea among colleagues?

I'm fairly sure that if people had an idea what the problem really is,
it would be solved in the forseeable future.


 bd> Well, that need to be done as said, even though in fact that is
 bd> really uncommon though.

 >> I know -- just wanted to give you the complete picture. .)

 bd> At least it don't oops :)

That is always something. :)

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFALKMsbvivwoZXSsoRArVxAKCfBlekmol3TO7SCflpTo+SV+6GCwCdEwMY
41PIiTL2eGZzuyAR6p/vkR8=
=OMgf
-----END PGP MESSAGE-----
--==-=-=--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
