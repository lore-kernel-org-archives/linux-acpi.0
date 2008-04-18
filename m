From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 07/53] PNP: make pnp_add_card_id() internal to PNP core
Date: Fri, 18 Apr 2008 14:50:02 -0600
Message-ID: <20080418205048.622698411@ldl.fc.hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761453AbYDRUyD@vger.kernel.org>
Content-Disposition: inline; filename=pnp-make-pnp_add_card_id-internal-to-core
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

pnp_add_card_id() doesn't need to be exposed outside the PNP core, so
move the declaration to an internal header file.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-By: Rene Herman <rene.herman@gmail.com>

Index: work7/drivers/pnp/base.h
===================================================================
--- work7.orig/drivers/pnp/base.h	2008-04-02 15:17:49.000000000 -0600
+++ work7/drivers/pnp/base.h	2008-04-02 15:19:07.000000000 -0600
@@ -4,6 +4,7 @@
 void pnp_eisa_id_to_string(u32 id, char *str);
 struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id, char *pnpid);
 struct pnp_id *pnp_add_id(struct pnp_dev *dev, char *id);
+int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card);
 int pnp_interface_attach_device(struct pnp_dev *dev);
 void pnp_fixup_device(struct pnp_dev *dev);
 void pnp_free_option(struct pnp_option *option);
Index: work7/include/linux/pnp.h
===================================================================
--- work7.orig/include/linux/pnp.h	2008-04-02 14:39:11.000000000 -0600
+++ work7/include/linux/pnp.h	2008-04-02 15:19:07.000000000 -0600
@@ -371,7 +371,6 @@
 void pnp_remove_card(struct pnp_card *card);
 int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
 void pnp_remove_card_device(struct pnp_dev *dev);
-int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card);
 struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink,
 					const char *id, struct pnp_dev *from);
 void pnp_release_card_device(struct pnp_dev *dev);
@@ -423,7 +422,6 @@
 static inline void pnp_remove_card(struct pnp_card *card) { }
 static inline int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_card_device(struct pnp_dev *dev) { }
-static inline int pnp_add_card_id(struct pnp_id *id, struct pnp_card *card) { return -ENODEV; }
 static inline struct pnp_dev *pnp_request_card_device(struct pnp_card_link *clink, const char *id, struct pnp_dev *from) { return NULL; }
 static inline void pnp_release_card_device(struct pnp_dev *dev) { }
 static inline int pnp_register_card_driver(struct pnp_card_driver *drv) { return -ENODEV; }

-- 
