Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435772;
	b=Iimz0xbpUUMF/tpxN3p3u5Eqe2wdwYvPvYC7hHAm6oN7a8egWZ+7gjIcZ4ygemgchuHI
	 p2809zMQhugTE/9ARfMOyR0RNtRKElrUhe9H4gvX4k1AK3ZdPnXOTntUakN8BmbKwpakj
	 75eFem4KN/xGaan3KHj8O5R42WKWhXpiqAj94GiR9u9prz/8xdG2ZKJqyt55n3AVSL7ak
	 VdzxsoV+/waC0OB1rKMsoZz4Jh+lzsXY18eQtA5DRqp4Kv6ECGkM2QlhgSWRCAq1d1elC
	 fVM2PPd8nybDVIkdIeCrL61Gt+MsutdCpjM+Z7eAugYMMtru1T+nNWOtBj9581rBSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=MOSUyRgfPJO47oTq4VBkWpT+RLTK5kL/NVumirQl9G8=;
	b=hL7YjqvN/kTKXvtm2uPSD6dejkheLVAktzYteKo+MKDc32nLGs693Deu0jF50Rm67ft7
	 PPzRA5Yy6JqplpOTQHiOKbmiTeACtCJXeO1FY6eJdZXV9KOo/48hzMM3ewsmxr3Mx9X70
	 jWWUx8QVOt0Psi8uE1mYGnVYmleomVbK6uzhKBRvFuKAhNkAdvoyRGzEOhnSNRAbz17iU
	 1A1UVw+wna7MurQEVfPBV5vS/O/fHFzLFj5+8ztAPUU2Xc/s5eBE9UpEEwHRqQju3nwlE
	 4nqX1hLU11d0cGN+DVt98Ducmw3cRn4REwnlnR8/pBtvU3RWRanl28U2sXlOkoNELsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fO6MZDZO;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5FA606A332
	for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2026 12:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A5FA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fO6MZDZO
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so2286775f8f.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2026 04:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795435769; x=1796040569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOSUyRgfPJO47oTq4VBkWpT+RLTK5kL/NVumirQl9G8=;
        b=fO6MZDZOb2UGccheqr7ZC7v5mNXg7UJBUFO0CUokvX2o1o9EhtlD3bUcYHOBm8zm6l
         KRb4VsMpDofuEGjNQxQSRRaSIVf8UZYPFbTBRHqeiA5RTZLgjV1MDiTbeZVlMom8jjgo
         yXLPWPsh/6NCOcAMJNIGesIAGdPtf0Qn0cJPjSE4gdzvBEO3J8hq6drMKA2lRcl3GHWX
         I9I8Sz2Mo+ffhApvIOoghhU9JmVtm04KURIcVC/RD1KJhtie1ImYQE8o0+e1qQkNPl6Q
         cazCXqN97ZFmDM/w7AIG+H9l773cpdiWDxgS+K6sSMTzyj5DjgUeLwbJ678lmBqsOhe4
         TvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435769; x=1796040569;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MOSUyRgfPJO47oTq4VBkWpT+RLTK5kL/NVumirQl9G8=;
        b=MUf6Vu3YwhcEdGwOh+tf63NIAi9h1dLRsWYC1AMpCPa4kskHxvYhgcooYc+fFdGAOG
         eJ6DmVH8TxtBgnVWxUjUgwC7FOe0WMPnFNjFNKT3TjXDCoM9UsWl3q5VU0nlDiy41Paa
         TkElY3my2mQ4YxSuik9sMKWnlR/100uQAY4P//fEW8TN+sYidUsm9CDe+7ZbDFyDbwly
         ezuJZ97FA4DPihHnLXtFrIIrERRCkffSXBciGUTkdWWL/NF2jFQUg5PMPp9d6KIv4z6Z
         R8tSPvmC7Q9yMtr7kvpjKJpChRsUZZap2SgoiN5vYB44B/apTKG0xZBdyXzZq+L6yLbD
         ApSQ==
X-Forwarded-Encrypted: i=1; AL+hErFDKgMPf5oyCaNiV0yqyaT2CSHCkNMkO2NFiV/TBhSE0aqGQZ96xuT6pI4V7z+VBfEsmkZunA0Tm73K@vger.kernel.org
X-Gm-Message-State: APuU4Z826KZCabXyPGYJt7Lx7D3JXpAjI2u6QrJMKcs9LLx9yU6wE5fk
	C1cfmMFr1aH7HgI5EQYYipNQTcHjMo6gnd7CxSWw5FF3Iec90IINP49rZDBTdN7Y/t8=
X-Gm-Gg: AZFdTZe+su1XVwyB4L6X6cJIk0Tq6SUh+UWI1neu2vUcjjSVEu5z8iGADEkqx4JRT76
	Yqjd0cSjDNd14dNW5zeBBdA8dNWqGt3g0RjUnbWWlvugFm9uwgPXou6nM9kVdL7CFMif2JQfjrZ
	rLh7tMO9wI9a9k9Y5QmfpFIygTNMlW2u81oKgUEUcYT1jzI3dODLy50BJgwf68x3sJA3hG9BeYc
	1rpK9/xz4/ONKDAGQ3udM11J4EzNCWgLQpsmpP49Prybq1qOl4/LoF9Zs6eRQGfuzuFn1esDfKi
	t0IIfhJRJ+gUrJnS6cFd3eyAT5bpn2JWyiyQ5sdQbuORC1Pj7UEff/4SZAdjSXBAg+9iTOjBlYG
	fTJE7rFN+nN7eFQslwjCJJsHZp244nyZTDCgxv2wB7fuoYJSb8TTdl4h+J1Qu+T9vnRTpNpe65T
	U4vDDCs907oQYFK35kTKy4WwXkruPhZxwid2JMUvpSoDs9EJC4xvkOv664LawOveVi9rULpqCPU
	197ubW+tGEZQ0mAlAGvvwrCosfnagsFAo9D8xmup/PQvmkOwM9dt7ZI/So9a7EabbyZLD0TMp9n
	Vmeyh5yR6aK9HoBi2FGOPaSS6QoWpZGoxpmjKCjQeDkzGk+sDn0yYJd/HNbg1T8Dw9bDZUBBAWl
	HruwXaW76U44v0q6O
X-Received: by 2002:a5d:64c8:0:b0:4a6:c5f4:cdf7 with SMTP id ffacd0b85a97d-4abaa976b7fmr20283637f8f.5.1795435769345;
        Mon, 23 Nov 2026 04:09:29 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab658e2d55sm22103392f8f.5.2026.11.23.04.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:09:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v1 RESEND] pnp: Documentation improvements
Date: Mon, 23 Nov 2026 13:09:19 +0100
Message-ID: <20261123120920.2569882-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2832; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=RWvctio2iC5bvxeB0uVnbkQOnoWZqDlCKT2BtO2MqaE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhmwWnQ8Gipub/ZPLMz+VypWJKv/h049RYi5ov5vmY/6dh 5Xx+4FORmMWBkYuBlkxRRb7xjWZVlVykZ1r/12GGcTKBDKFgYtTACbS6sbBsJpX80du0+wI2fM8 dzt/LN16qpO1YEpEw/ofwnxajBf4z+fmruqek6di/irqUeIlr1zeRdVLq3/XOd55KJL//K5ayKl fO9WTb9vbLNL8zr+Zp0fHecsSli/sZ2X2nPpyaNVf7iv88gbNcc1rnSYaeLZnaGgvkIrUl4xceD Pbk904YbedsmU1p8qsA64bp7AEc14uuTzXcHdua51MOMu55sv3L3LbHDZd8ehZbcpkbdebPW8Wh TQYLCthiBG6E5pU8NP99dfqP5UF3Ku7d9b7rbrcYi3ws14oZrUK17aOrQI6mxZm7D4U75phF225 wyuwKu4u45wd9y6+9/wnonaR53alCu+SabfkDbtSF+kAAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

 - Consistently use named initializers and simplify sentinel
 - Skip assignment to .driver_data if all are 0
 - Use consistent spacing to match Linux coding style
 - Fix prototype of probe function
 - s/pnp_id/pnp_device_id/
 - Drop non-existing .card_id_table

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch was already send before[1], Rafael replied "I'll pick it up,
but please send it to linux-acpi@vger.kernel.org for easier processing."
which I failed to do until now.

This is a clean rebase to next-20261120, the file didn't change in 2026
yet, so it's essentially the same patch.

Best regards
Uwe

[1] https://lore.kernel.org/20260609145117.1355753-2-u.kleine-koenig@baylibre.com

 Documentation/admin-guide/pnp.rst | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/pnp.rst b/Documentation/admin-guide/pnp.rst
index 24d80e3eb309..14a0bf400d2d 100644
--- a/Documentation/admin-guide/pnp.rst
+++ b/Documentation/admin-guide/pnp.rst
@@ -203,12 +203,12 @@ The New Way
 
    ex::
 
-	static const struct pnp_id pnp_dev_table[] = {
+	static const struct pnp_device_id pnp_dev_table[] = {
 		/* Standard LPT Printer Port */
-		{.id = "PNP0400", .driver_data = 0},
+		{ .id = "PNP0400" },
 		/* ECP Printer Port */
-		{.id = "PNP0401", .driver_data = 0},
-		{.id = ""}
+		{ .id = "PNP0401" },
+		{ }
 	};
 
    Please note that the character 'X' can be used as a wild card in the function
@@ -217,14 +217,14 @@ The New Way
    ex::
 
 	/* Unknown PnP modems */
-	{	"PNPCXXX",		UNKNOWN_DEV	},
+	{ .id = "PNPCXXX", .driver_data = UNKNOWN_DEV },
 
    Supported PnP card IDs can optionally be defined.
    ex::
 
-	static const struct pnp_id pnp_card_table[] = {
-		{	"ANYDEVS",		0	},
-		{	"",			0	}
+	static const struct pnp_device_id pnp_card_table[] = {
+		{ .id = "ANYDEVS" },
+		{ }
 	};
 
 2. Optionally define probe and remove functions.  It may make sense not to
@@ -234,14 +234,13 @@ The New Way
    ex::
 
 	static int
-	serial_pnp_probe(struct pnp_dev * dev, const struct pnp_id *card_id, const
-			struct pnp_id *dev_id)
+	serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	{
 	. . .
 
    ex::
 
-	static void serial_pnp_remove(struct pnp_dev * dev)
+	static void serial_pnp_remove(struct pnp_dev *dev)
 	{
 	. . .
 
@@ -253,7 +252,6 @@ The New Way
 
 	static struct pnp_driver serial_pnp_driver = {
 		.name		= "serial",
-		.card_id_table	= pnp_card_table,
 		.id_table	= pnp_dev_table,
 		.probe		= serial_pnp_probe,
 		.remove		= serial_pnp_remove,

base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.56.0.rc1

