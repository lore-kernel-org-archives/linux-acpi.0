From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: S2R gone with 2.6.12-rc1-mm1
Date: Wed, 25 May 2005 17:03:13 -0700
Message-ID: <20050525170313.390f26f8.akpm@osdl.org>
References: <20050321210411.GB29072@gamma.logic.tuwien.ac.at>
	<20050321132106.3cb48d38.akpm@osdl.org>
	<20050322110610.GB1940@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050322110610.GB1940-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Norbert Preining <preining-DX+603jRYB8@public.gmane.org> wrote:
>
> On Mon, 21 M=E4r 2005, Andrew Morton wrote:
> > > Sorry to bother you again, but I found that S2R does not work anymore
> > > with 2.6.12-rc1-mm1, while it works with the exact same software setup
> > > with 2.6.11-mm4.
> >=20
> > Oh.  suspend-to-RAM.
> >=20
> > Would this be an ACPI regression?
>=20
> Sorry for the S2R. I guess that it is related to the new ACPI stuff
> introduced in bk-acpi lately. What would you suggest:
>=20
> Taking the bk-acpi patch from 2.6.11-mm4 and use it instead of the one
> in 2.6.12-rc1-mm1? I guess this will not really work?!

I've lost the plot on this bug.  If 2.6.12-rc5 has the problem, please
shout loudly.

If 2.6.12-rc5-mm1 has the bug, please raise a new bug report, preferably
via kernel bugzilla, thanks.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
