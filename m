From: "Nick Bartos" <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org>
Subject: acpi=force safe?
Date: Thu, 5 Feb 2004 23:14:15 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40678.65.28.18.238.1076044455.squirrel@mail.diamondcpu.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
References: 
In-Reply-To: 
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I manage a little router distro that uses acpi to do a clean shutdown whe=
n
the power button is tapped.  So really I am only using the powerdown &
button event features.

The problem I am having is that a lot of the boards I use are older, and
acpi does not get enabled by default.  In the distro I want to keep
everything consistent, so if I fix this problem by forcing acpi on, I wil=
l
want to do it globally (for all systems).

I can do acpi=3Dforce, but I worry about causing stability issues.

I posted this question on the kernel devel list, and it was suggested to
me that I compile in basic acpi support button support, and nothing else.=
=20
Then I could do a acpi=3Dforce and just force on those features.

I am wondering if this will be safe, or if I could run into problems.  I
don't want to sacrifice stability to have these features, but I would lik=
e
all my boxes to be consistent.

At least one of the systems is an asus p4b266 (most boards are asus),
which is on the blacklist for acpi=3Dht.  I tried to force acpi on for th=
is
board which did work, but it gave me a warning about overriding acpi=3Dht
(which I really don't know what that is supposed to do).

If this is OK, then what other features can I enable and safely force acp=
i
on?  I would like to eventually implement fan speed and processor temp
monitoring (possibly other health monitoring).  For some router only boxe=
s
it may be good to reduce power consumption, but I don't want to push my
luck if it may not be safe.

I am using the latest 2.4.x pre at the moment.

Comments?





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
