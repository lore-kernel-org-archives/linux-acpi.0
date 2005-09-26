From: "Martin J. Bligh" <mbligh-4sHKUK52ZVEdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Mon, 26 Sep 2005 06:47:47 -0700
Message-ID: <373830000.1127742467@[10.10.2.4]>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com><20050921101855.GD25297@atrey.karlin.mff.cuni.cz><Pine.LNX.4.58.0509210930410.2553@g5.osdl.org><20050921173630.GA2477@localhost.localdomain><20050921203505.32cc714d.diegocg@gmail.com><20050921114948.5b423109.akpm@osdl.org><695600000.1127332498@flay> <20050926140900.d070b604.diegocg@gmail.com>
Reply-To: "Martin J. Bligh" <mbligh-4sHKUK52ZVEdnm+yROfE0A@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050926140900.d070b604.diegocg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Diego Calleja <diegocg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: akpm-3NddpPZAyC0@public.gmane.org, alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org, torvalds-3NddpPZAyC0@public.gmane.org, pavel-AlSwsSmVLrQ@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



--Diego Calleja <diegocg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote (on Monday, September 26, 2005 14:09:00 +0200):

> El Wed, 21 Sep 2005 12:54:58 -0700,
> "Martin J. Bligh" <mbligh-4sHKUK52ZVEdnm+yROfE0A@public.gmane.org> escribi=F3:
>=20
>> http://lists.osdl.org/mailman/listinfo/bugme-new
>>=20
>> But it's not "all changes/new bugs/random crap", it's "new bugs".
>> And it's all categories, but there's handy-dandy X- header fields
>> to filter on.
>=20
> I discovered this other ml: http://lists.osdl.org/mailman/listinfo/bugme-janitors=20
>=20
> So, http://lists.osdl.org/mailman/listinfo/bugme-new is just for new bugs
> and http://lists.osdl.org/mailman/listinfo/bugme-janitors for everything else,
> or bugme-janitors is non-functional? (I tried to subscribe to check it myself but
> subscription requires "moderator approval")

Ooops. shouldn't do. will fix.

> If so, can we have the bugme-janitors and bugme-new archives opened for
> everyone (so google can index it?)

Yeah, sounds fair enough (though I think google will index bugzilla too)

M.




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
