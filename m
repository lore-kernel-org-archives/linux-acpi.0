From: "Suso Baleato" <susinho@ultreia.org>
Subject: BIOS Update: new dsdt for ThinkPadP R51
Date: Wed, 15 Sep 2004 08:25:02 +0000
Sender: linux-thinkpad-admin@linux-thinkpad.org
Message-ID: <20040915082407.7A5CD83F6@smtp.causaencantada.org>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: acpi-devel@lists.sourceforge.net, linux-thinkpad@linux-thinkpad.org
List-Id: linux-acpi@vger.kernel.org

I discovered an august 2004 BIOS update for R/T ThinkPads with a Linux
fix inside.

(Fix) (Linux) Hibernation function does not work correctly under the
partition environment created by lphdisk.

After system's update I extracted and published the (again buggy) DSDT
table in the ACPI database. If you can correct the bug, please publish
the fixed DSDT as well, thank you.

http://www-1.ibm.com/support/docview.wss?rs=3D0&q1=3D1830&uid=3Dpsg1MIGR-5027=
5&loc=3Des_ES&cs=3Dutf-8&cc=3Des&lang=3Des+en
-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
