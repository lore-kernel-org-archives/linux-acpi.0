From: Dumitru Ciobarcianu <swsusp-devel@lnx.ro>
Subject: Re: Cause of Suspend2 resume failures on Toshiba
	laptops
Date: Sun, 06 Mar 2005 19:34:40 +0200
Message-ID: <1110130480.14605.16.camel@DustPuppy.LNX.RO>
References: <422B33C9.nailFXZ11PEDH@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <422B33C9.nailFXZ11PEDH@berlios.de>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: mhf@berlios.de
Cc: acpi-devel@lists.sourceforge.net, suspend2-devel@lists.suspend2.net
List-Id: linux-acpi@vger.kernel.org

=C3=8En data de Du, 06-03-2005 la 17:46 +0100, mhf@berlios.de a scris:
> I am afraid the only effect of the patch on my Toshiba L2
> is that the RTC stops working, thus the rtc.ko module can
> not be inserted (no such device).

Please revert the first patch and use the second and the 3rd.
toshiba-acpi-hack-2.diff and toshiba-acpi-hack-3.diff.=20
(if you already did that i'll just shut up and sit in a corner :)

--=20
Cioby
