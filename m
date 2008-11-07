From: Greg KH <gregkh@suse.de>
Subject: [patch 09/23] ACPI: Always report a sync event after a lid state
	change
Date: Fri, 7 Nov 2008 15:15:41 -0800
Message-ID: <20081107231541.GJ1108@kroah.com>
References: <20081107224818.593212310@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:59250 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753689AbYKGXXA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Nov 2008 18:23:00 -0500
Content-Disposition: inline; filename="acpi-always-report-a-sync-event-after-a-lid-state-change.patch"
In-Reply-To: <20081107231457.GA1108@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Jake Edge <jake@lwn.net>, Eugene Teo <eteo@redhat.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, Guillem Jover <guillem.jover@nokia.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

2.6.26-stable review patch.  If anyone has any objections, please let u=
s know.

------------------

=46rom: Guillem Jover <guillem.jover@nokia.com>

upstream commit df316e939100e789b3c5d4d102619ccf5834bd00

Currently not always an EV_SYN event is reported to userland
after the EV_SW SW_LID event has been sent. This is easy to verify
by using =E2=80=9Cinput-events=E2=80=9D from input-utils and just closi=
ng and opening
the lid.

Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
Acked-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/acpi/button.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -262,6 +262,7 @@ static int acpi_lid_send_state(struct ac
 		return -ENODEV;
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
+	input_sync(button->input);
 	return 0;
 }
=20
@@ -285,8 +286,8 @@ static void acpi_button_notify(acpi_hand
 			input_report_key(input, keycode, 1);
 			input_sync(input);
 			input_report_key(input, keycode, 0);
+			input_sync(input);
 		}
-		input_sync(input);
=20
 		acpi_bus_generate_proc_event(button->device, event,
 					++button->pushed);

--=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
