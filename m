Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3441325B;
	Fri,  8 May 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262354; cv=none; b=Rv/9NHfb23ttInqA/g0cM6vHHzl4klL6rZSWKKUt6o6iWqx0OVz5fM1YNCwObkUi5+j10OQ0DI0D1snAFYf3h/UOLB9u62eNlzQjVsAiASU4RFyvrxgN/X4OsA8bfpj7SXDdOaHhku5DEkpBce4ZPW1TPVrDzEdgc+kaTanff9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262354; c=relaxed/simple;
	bh=RT1iSLXcn3x4zX54LUyoyaOgntYKhUNKvz82UTOuDH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwCkIz43hfWNqK143/Wm6B6PhHCzoNfVC4iaTvFDKeQl0k5EPMQDExoh3+QziaTsgzjBY+yCsbKlE9VUNNFQIVl5sN+RYKOnwFZG0yGSZf6rAhrgulBHdRplx4oGz4MwT5eLr3JwQNpJaY+1HstGrsvXb1FhO4L1zcmmWG4D9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCYgSsmD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCYgSsmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0E4C2BCC7;
	Fri,  8 May 2026 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262354;
	bh=RT1iSLXcn3x4zX54LUyoyaOgntYKhUNKvz82UTOuDH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCYgSsmDHylOgoVTWzo+KfLiC0ykeZIT2nSkHjSEqoRw6/mfKaip1xJ/P3oQsEY/p
	 Wx3TPFQjbmskjGLoiJCBtI630yk94LZKczgVSPNVev2RNlA3pwxi8iCkAnEdNoBhKa
	 Zw08VaM6c5QxhK+nGtxShg3H1+H6qs28VzVfbTiNEmA1jvzJziX7O9hUS8YCDSE1h/
	 G1fpm28ncZNekCF1TL6Zae+bxv4GKvpp9HCmI3c8AKoJFrEohOzrWu7N8Mek6NoRiY
	 RkEklKVM9FSbCkywgGcaFiWjdNuWkZo4mrN4xeZ0XbJQTIf1jJUPVFGe8doJqPINdb
	 IGonlHJr1vL3A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 2/4] platform/x86: xo15-ebook: Fix formatting of labels
Date: Fri, 08 May 2026 19:41:47 +0200
Message-ID: <14016199.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2420444.ElGaqSPkdT@rafael.j.wysocki>
References: <2420444.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Fix formatting of two labels in ebook_switch_add() to make that
function follow the current kernel coding style more closely.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 1568169b7872..616f4bb3461a 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -134,9 +134,9 @@ static int ebook_switch_add(struct acpi_device *device)
 
 	return 0;
 
- err_free_input:
+err_free_input:
 	input_free_device(input);
- err_free_button:
+err_free_button:
 	kfree(button);
 	return error;
 }



