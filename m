From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 7 Aug 2002 17:17:19 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807231722.6087.qmail@scrye.com>
References: <20020807224648.5744.qmail@scrye.com>
	<200208072257.SAA04328@magic-pi-ball.mit.edu>
	<20020807230502.GA3563@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020807230502.GA3563-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Charl" == Charl P Botha <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org> writes:

Charl> On Wed, Aug 07, 2002 at 06:57:25PM -0400, Sourav K Mandal
Charl> wrote:
>> > The Fn f7 (dim) and Fn-f8 (brighten) and Fn-F4 (monitor) all work
>> fine > when I first boot up. They also work fine if I start X with
>> no DRM. If > I start X with drm, then they stop working and won't
>> work again until > I reboot.
>> 
>> Exactly what I'm getting, but with stock DRI modules.

Charl> Just for clarity, on my laptop (which is not a Compaq, but a
Charl> no-namer with Radeon Mobility 7500 64MB) the bright/dim keys
Charl> always work, DRI or no DRI.

so it might be a bios diffrence... ?

>> My (layman's) guess is that it has something to do with the GPU's
>> power state.  The BIOS won't shut down the LCD until it's satisfied
>> with the Radeon's power state; once DRM is used the Radeon cannot
>> enter an acceptable power state.

Charl> If you experience this with stock XFree86 DRI as well, I would
Charl> post a report on xpert-72qDnkntNoRAfugRpC6u6w@public.gmane.org as well.  One of the ATI
Charl> engineers is spending a lot of time with these drivers and
Charl> might have something to add to the equation.

ok. I will try and test it later tonight and see. I can't remember if
I saw it with stock X/drm or not. 

>> This is the inverse of the DRI-on-resume problem, that once the
>> Radeon is shutdown w/o reset, the DRM "parts" don't wake up
>> properoly.

Charl> The DRM wasn't designed for stopping/starting in mid-stride,
Charl> which is why we've made it so that it completely
Charl> initialises/de-initialises during VT-switch.  If certain
Charl> remaining technical problems can be sorted out, this might even
Charl> make XFree86 4.3.0, at least until a more generic solution can
Charl> be implemented.

excellent. 

Charl> Good luck, Charl

kevin


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE9UaqC3imCezTjY0ERAgHVAJ9mLzQXUEQ893HzqDAbipwoLnUbzACeKd+B
ofgte2+w7GMrGw8cLlTVdA8=
=gczI
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
