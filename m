From: "Georg C. F. Greve" <greve@gnu.org>
Subject: Re: [ACPI] Re: status update for current development on ASUS M2N
Date: Mon, 27 Sep 2004 15:28:34 +0200
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <m3d607g7st.fsf@brain.gnuhh.org>
References: <m3lleww12c.fsf@brain.gnuhh.org>
	<20040927123320.GA28634@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20040927152834+0200-7410138712642398310629575";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <20040927123320.GA28634@hell.org.pl> (Karol Kozimor's message of
	"Mon, 27 Sep 2004 14:33:20 +0200")
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: acpi-devel@lists.sourceforge.net
Cc: SoftwareSuspend-devel@lists.berlios.de
List-Id: linux-acpi@vger.kernel.org

--20040927152834+0200-7410138712642398310629575

 || On Mon, 27 Sep 2004 14:33:20 +0200
 || Karol Kozimor <sziwan@hell.org.pl> wrote: 

 kk> I had that issue too, with 2.6.9-rc1 I s'pose, but I thought it
 kk> was just bug #3193 revisited and didn't really investigate. Does
 kk> changing swsusp2 to _not_ use ACPI S4 help?

It seems that this is not a compile-time option anymore and solely
determined by /proc/software_suspend/acpi_s4_support, right?

Output of 'cat /proc/software_suspend/acpi_s4_support' is '0'.

So unless something is activating it somewhere, somehow, it seems that
this _is_ with deactivated ACPI S4.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20040927152834+0200-7410138712642398310629575
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWBWCbvivwoZXSsoRAg/MAJkBcL9+vrem7y0jZ5d3nTEG0u1qsgCgiDYM
SPMEKJ3TVqEEf81c8XaAL1w=
=4ZTo
-----END PGP SIGNATURE-----
--20040927152834+0200-7410138712642398310629575--
