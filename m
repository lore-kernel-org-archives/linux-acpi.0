Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49FB8;
	Mon, 27 Nov 2023 11:57:46 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id ee40771b95509fa8; Mon, 27 Nov 2023 20:57:44 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C11986684FB;
	Mon, 27 Nov 2023 20:57:43 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler for SCI
Date: Mon, 27 Nov 2023 20:57:43 +0100
Message-ID: <5745568.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtgho
 mhdprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the current arrangement, all of the acpi_ev_sci_xrupt_handler() code
is run as an interrupt handler for the SCI, in interrupt context.  Among
other things, this causes it to run with local interrupts off which
can be problematic if many GPEs are enabled and they are located in the
I/O address space, for example (because in that case local interrupts
will be off for the duration of all of the GPE hardware accesses carried
out while handling an SCI combined and that may be quite a bit of time
in extreme scenarios).

However, there is no particular reason why the code in question really
needs to run in interrupt context and in particular, it has no specific
reason to run with local interrupts off.  The only real requirement is
to prevent multiple instences of it from running in parallel with each
other, but that can be achieved regardless.

For this reason, use request_threaded_irq() instead of request_irq() for
the ACPI SCI and pass IRQF_ONESHOT to it in flags to indicate that the
interrupt needs to be masked while its handling thread is running so as
to prevent it from re-triggering while it is being handled (and in
particular until the final handled/not handled outcome is determined).

While at it, drop a redundant local variable from acpi_irq().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The code inspection and (necessarily limited) testing carried out by me
are good indications that this should just always work, but there may
be still some really odd platform configurations I'm overlooking, so if
you have a way to give it a go, please do so.

---
 drivers/acpi/osl.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -544,11 +544,7 @@ acpi_os_predefined_override(const struct
 
 static irqreturn_t acpi_irq(int irq, void *dev_id)
 {
-	u32 handled;
-
-	handled = (*acpi_irq_handler) (acpi_irq_context);
-
-	if (handled) {
+	if ((*acpi_irq_handler)(acpi_irq_context)) {
 		acpi_irq_handled++;
 		return IRQ_HANDLED;
 	} else {
@@ -582,7 +578,8 @@ acpi_os_install_interrupt_handler(u32 gs
 
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
-	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
+	if (request_threaded_irq(irq, NULL, acpi_irq, IRQF_SHARED | IRQF_ONESHOT,
+			         "acpi", acpi_irq)) {
 		pr_err("SCI (IRQ%d) allocation failed\n", irq);
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;



