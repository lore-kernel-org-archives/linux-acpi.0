From: Jeremy Moles <jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org>
Subject: ACPI+Userspace
Date: Mon, 13 Jun 2005 19:37:36 -0400
Message-ID: <1118705856.3814.6.camel@localhost>
Reply-To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all--quick question.

As bad as it may seem, I was wondering if it is possible to generate
ACPI events in userspace? That is: propogate any arbitrary "string" up
through the ACPI subsystem, eventually getting dumped
to /proc/acpi/event which, in our case, is being watched and acted on by
the userspace util ACPID.

The obvious answer is: "Call /etc/acpi/hander with your string!"--which
is always an option--but I'd like to know if it's possible simply to use
for testing/debugging. I could write a driver supporting ioctls to pass
stuff via acpi_bus_generate_event (I think?), but that's wayyy too much
work for what I'm wanting this for. I'm sure there are reasons this
isn't a good idea, and I'd be glad to hear those too (to increase my
understanding of ACPI!).

Anyway--thanks ahead of time. Weee.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
