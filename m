From: "Georg C. F. Greve" <greve@gnu.org>
Subject: Re: status update for current development on ASUS M2N
Date: Sat, 02 Oct 2004 00:31:57 +0200
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <m3ekkiqdcy.fsf@brain.gnuhh.org>
References: <20040930214808.B5D9C3AA515@ws5-8.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20041002003157+0200-21114919-4450113298928427";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <20040930214808.B5D9C3AA515@ws5-8.us4.outblaze.com> (Nigel
	Cunningham's message of "Fri, 01 Oct 2004 07:48:08 +1000")
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: ACPI List <acpi-devel@lists.sourceforge.net>, SoftwareSuspend-Devel <softwaresuspend-devel@lists.berlios.de>
List-Id: linux-acpi@vger.kernel.org

--20041002003157+0200-21114919-4450113298928427

 || On Fri, 01 Oct 2004 07:48:08 +1000
 || "Nigel Cunningham" <ncunningham@linuxmail.org> wrote: 

 >> Can you tell me how to do this, please?

 nc> The simplest way is to do a digital photograph, I'm afraid. The
 nc> 'nice' way is to hook up a serial console and capture the output.

That is rather inconvenient.

I'm curious. Any reason that nobody implemented something to do this?

I would assume that a kdb buffer that is reserved at startup,
initalized with 0s and into which only kdb can write during debugging.

When kdb is left and the buffer is different from 0, the contents are
dumped to dmesg/syslog.

This appears to me like it would be a rather simple solution to avoid
having to send around pictures or using a second computer...


 nc> If you do a photo, just send it to me, please.

Just did that. Please confirm that you got it and it did not get stuck
anywhere on the way.

Hope this helps,

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041002003157+0200-21114919-4450113298928427
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBXdrdbvivwoZXSsoRAt3CAJsHk++btmpCPjz/ye1huujjt0iegwCfQ79V
kYXlW5IUQSxLUvt9MaVScl4=
=u30S
-----END PGP SIGNATURE-----
--20041002003157+0200-21114919-4450113298928427--
