From: "Georg C. F. Greve" <greve@gnu.org>
Subject: Re: status update for current development on ASUS M2N
Date: Wed, 06 Oct 2004 12:22:43 +0200
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <m31xgcxi18.fsf@brain.gnuhh.org>
References: <20040930214808.B5D9C3AA515@ws5-8.us4.outblaze.com>
	<m3ekkiqdcy.fsf@brain.gnuhh.org>
	<1097019863.16541.47.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="20041006122243+0200-3026523736900844-7630649";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <1097019863.16541.47.camel@desktop.cunninghams> (Nigel
	Cunningham's message of "Wed, 06 Oct 2004 09:44:23 +1000")
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: ncunningham@linuxmail.org
Cc: ACPI List <acpi-devel@lists.sourceforge.net>, SoftwareSuspend-Devel <softwaresuspend-devel@lists.berlios.de>
List-Id: linux-acpi@vger.kernel.org

--20041006122243+0200-3026523736900844-7630649

 || On Wed, 06 Oct 2004 09:44:23 +1000
 || Nigel Cunningham <ncunningham@linuxmail.org> wrote: 

 >> When kdb is left and the buffer is different from 0, the contents
 >> are dumped to dmesg/syslog.

 nc> Something like printk :> It wouldn't work with suspending because
 nc> we're overwriting such buffers when copying the original kernel
 nc> back (with the contents from suspend-time). Furthermore, it won't
 nc> help if you get such a crash because you're never going to start
 nc> syslogd and get the data written.

I agree that it would not help in all cases.

In this case it would have helped, though. The machine is running,
syslog is doing its job -- that is how I got the sysrq-T output.

So if kbd had support for that, we could have saved ourselves the
trouble of taking a photograph of the screen and mailing that around.

Speaking of which: Since you told me that you did not see it, I just
resent it, please let me know whether it reaches you this time.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041006122243+0200-3026523736900844-7630649
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBY8dzbvivwoZXSsoRAiXXAKC2FFo4xcjvzNH80eMgclCQ2pG/LgCeN41H
V/A+S8HWcHSd3uNZz4Bk2EQ=
=7Yty
-----END PGP SIGNATURE-----
--20041006122243+0200-3026523736900844-7630649--
