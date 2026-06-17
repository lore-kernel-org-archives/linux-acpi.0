Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5AE3B7B71;
	Wed, 17 Jun 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704526; cv=none; b=VoWslWafJ5Tek1BL0sIa5Y5GXGWmYA+U8DvOoIYckUALGwZE8kOw39n8XuWDBp9AvspzmaSLdLeZUabR5qlNEHSDWOA8p7ganARYV3nTu1Gafqx2rJMQY3GrpWLIguRUnpWL/Tb5hcPoo6plCsHYAmwUzUWqsqJvvvAsOd9nBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704526; c=relaxed/simple;
	bh=zyyLveHv8Uan+ttntZ1slJVe8DTbBlxt6FNCdMciMco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vdxq1UDesgKRQrEs5lTg4pnidsoa17fPHlP3jyOzWZYUFDe1yjEhMcnTPxF35FSe68Wrp0SLQghIKxSi8tbnm49mLHNOdR/SfZ/ECkiRXHJF/VZCsQVD3g9oPoVxcsrtJg1IB06GbmFt/GTkY0kuMTM3pv6kb3N+sIFxSNeYKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=RmuN2n6P; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="RmuN2n6P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=xmciLzBE/vu88QuDUuZ46Cz/+RA210gU9AjSvokctpg=; b=RmuN2n6PGpVbyP
	E3YQsmMR9t7OymMONFo63FMGzbbl8GrSGOSQzbwgn5tOjBbpZ/GGQ6Sl5hJSEZBOdaT6/2DvFSHHp
	f/W6eI4i929pGGqm96j1XiU5NmiEK+huGOQSKQ5B28ulefF2mknP0jdaODDkCLexn73tacNoT3m9o
	tFMeZe1URHn/mSvsyL7vXiQPa77Ez6nzGjRGc6XRryguWP9+9x/4DaBbuc/IHU6Ya2ZF6q7gQtf9w
	CTBR/7zz1XjqjPpwQ04OflPyPCY7How/hBfZLaFyHKOq4O1dOjl5L8dDnjJle3wj6xa91bnQzhPKO
	I5peqxSzwpUP2LIlv3Mw==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZqjh-00DZJJ-Lr; Wed, 17 Jun 2026 14:55:21 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wZqjh-00000004cLP-1wC7;
	Wed, 17 Jun 2026 14:55:21 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] PNP: make pnp_eisa_id_to_string() take __be32 id
Date: Wed, 17 Jun 2026 14:55:18 +0100
Message-Id: <20260617135518.1100698-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The pnp_eisa_id_to_string() should take a __be32 id as it
passes it immediately to be32_to_cpu(). Change the type
of this to fix the following sparse warning:

drivers/pnp/support.c:42:14: warning: cast to restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/pnp/base.h    | 2 +-
 drivers/pnp/support.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index b342570d0236..7b666b6ac40e 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -11,7 +11,7 @@ extern const struct bus_type pnp_bus_type;
 int pnp_register_protocol(struct pnp_protocol *protocol);
 
 #define PNP_EISA_ID_MASK 0x7fffffff
-void pnp_eisa_id_to_string(u32 id, char *str);
+void pnp_eisa_id_to_string(__be32 id, char *str);
 struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id,
 			      const char *pnpid);
 struct pnp_card *pnp_alloc_card(struct pnp_protocol *, int id, char *pnpid);
diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
index f6c866851769..07c9844680ac 100644
--- a/drivers/pnp/support.c
+++ b/drivers/pnp/support.c
@@ -37,9 +37,9 @@ EXPORT_SYMBOL(pnp_is_active);
  * Functionally similar to acpi_ex_eisa_id_to_string(), but that's
  * buried in the ACPI CA, and we can't depend on it being present.
  */
-void pnp_eisa_id_to_string(u32 id, char *str)
+void pnp_eisa_id_to_string(__be32 _id, char *str)
 {
-	id = be32_to_cpu(id);
+	u32 id = be32_to_cpu(_id);
 
 	/*
 	 * According to the specs, the first three characters are five-bit
-- 
2.37.2.352.g3c44437643

