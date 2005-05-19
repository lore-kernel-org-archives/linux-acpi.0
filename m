From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc@tiscali.be>
Subject: ACPI errors with software suspend and smartbattery
Date: Thu, 19 May 2005 15:39:20 +0200
Message-ID: <428C9708.8070708@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <suspend2-users-bounces@lists.suspend2.net>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-users>,
	<mailto:suspend2-users-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-users.html>
List-Post: <mailto:suspend2-users@lists.suspend2.net>
List-Help: <mailto:suspend2-users-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-users>,
	<mailto:suspend2-users-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-users-bounces@lists.suspend2.net
Errors-To: suspend2-users-bounces@lists.suspend2.net
To: suspend2-users@lists.suspend2.net, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hello everybody,
I have a smartbattery and I use therefore the sbs patches made by Rich
Townsend to obtain the state of my battery. I have a little problem with
software suspend (release 2.1.8.7 on kernel 2.6.11.10). On resume, I get
the following errors:
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_TZ_.THRM._TMP]
(Node dfec9e40), AE_TIME
    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC0_.SMB0._SBR] (Node dfec9d20), AE_TIME
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC0_.SMB0.SBRW] (Node dfeca780), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.ACQB] (Node
dfeca700), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.BAT0.CKAL]
(Node dfeca480), AE_TIME
    ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC0_._Q09] (Node dfeca120), AE_TIME
That doesn't seem to be a big problem. After resuming, ACPI seems to
work without problem and I can still get all ACPI info and events.
However, does somebody know what these errors mean ?

Thanks in advance for your help,
Sincerely yours,
Fran=E7ois Valenduc
