Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C03D34B8;
	Wed, 11 Mar 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226735; cv=none; b=aQUnTPMLM2YBVc52hBSjl9dGlxPpiWFOyTxvLDYonVa2Xyhb9yDJsTj6oE4EF7h4hybeADWAtEYn7+ON6ezSEMqTCsscLkFatFkilskQ22IgK5l2tM5ajc4QbhaVgUw0LnIQB6+7MTA+tY5PzuLDaht/IdiD9Jj5Dq4zrlKh5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226735; c=relaxed/simple;
	bh=SzFvg8/rvQSBDdPTguwux85VtMkNl4rBP6gvg0rMOv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zr0SiRRj/iTja0A4YqsMErtHejAJIhbZXwbWqwovUy6EUHWhw67EKpxpp+0dEMRvl8xDcJCR52lOl5cUk8YRk9jogQJwwo0CA5LYrr6hsp3aYqBdKU+AqCHIEns+ZNrdSqFW1+6P1DJsNw6XqNbBjnYVsNaTs8DFuwVQBdnK3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=m6wPHti7; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="m6wPHti7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=//SfgjZqS5se3QSu9mBL2KLJEdrCIxiPobYvmDZHJ1I=; b=m6wPHti7nE5tp3
	fH4fY6z2YzIqy4Ay3zvMuRjY6+2xZay8qmRxhiY9GWpl08J1MJxla34JqGX+4pFhtR1ZyqFwT0LTs
	NphpWT5Ur/G3vc8l4HBjfqKdXvLY2d3M2uyxmT6DeBoMd3WG7xjWfVIlisl58Z5fI2YoSRkzE31Ya
	BkTlepzfnCSkM7EITX4xGNBbGFBVUUQmHyP2xbwHKW1NULK/cXy56O1Aj8KXKsb3x+PavPJoKAY/Q
	zfqI1UwWLMoCqtlUrOBqQrtWpSITbGQxgblmxw1lkeKXNM/WohcPbILa5yohz4ytSmOI6DObn6I90
	zMxwSEbKJG2sf+kbkMTQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1w0HGx-0085Vm-94; Wed, 11 Mar 2026 10:58:39 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1w0HGw-00000001wSR-2R6y;
	Wed, 11 Mar 2026 10:58:38 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-acpi@vger.kernel.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ACPI: OSL: fix __iomem type on return acpi_os_map_generic_address()
Date: Wed, 11 Mar 2026 10:58:35 +0000
Message-Id: <20260311105835.463030-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The pointer returned from acpi_os_map_generic_address() is
tagged with __iomem, so make the rv it is returned to also
of void __iomem * type.

Fixes the following sparse warning:

drivers/acpi/osl.c:1686:20: warning: incorrect type in assignment (different address spaces)
drivers/acpi/osl.c:1686:20:    expected void *rv
drivers/acpi/osl.c:1686:20:    got void [noderef] __iomem *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5b777316b9ac..62b9c83d4f20 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1681,7 +1681,7 @@ acpi_status __init acpi_os_initialize(void)
 		 * Use acpi_os_map_generic_address to pre-map the reset
 		 * register if it's in system memory.
 		 */
-		void *rv;
+		void __iomem *rv;
 
 		rv = acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
 		pr_debug("%s: Reset register mapping %s\n", __func__,
-- 
2.37.2.352.g3c44437643

