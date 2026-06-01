Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066D3DE427;
	Mon,  1 Jun 2026 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334032; cv=none; b=POK9r13xeACGGaIdZVglz4rrCw9GYrSF+bdtKWd9V6kgxtCWrY7OKmtI9jqmx3/ZgvdWvba+NFv3gyvlRgq+N0ZAMQ74OvUJBP5xcFQhn69dj1E1yt954R18KY6w3P51vVB4fOXk0RXn180fvf2v2s4FxiLxHKOVbhzZ5sc8hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334032; c=relaxed/simple;
	bh=yM4CkOHxRA12qkSQYUith11/2ERd4ABHgQ8sef3ZMrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fprt5nCAeoHQDAmfrUdhTwtP3DrLBxF/R7v3GpTT6ukwUJsp/m3SHqsMLyrJO4wPdTCLmmCLoBJqXq3mbACPxKM0+cHaIUeqc6LdjzqKh6oHj1yTUnP0sUI7TfkLHcx/FCoy4J1QFh2JnT9mB2t0WriixcxccRmlF9O4GQKI8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctHAu+Gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctHAu+Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578821F00898;
	Mon,  1 Jun 2026 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334031;
	bh=MNZVNgub9WBbR+R1qPIfI3MbbQDghl7TpKphkDcMGN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctHAu+Gg6zvuYZN7w8FIpyywy6pYrm5V3wZuczYKSNo5hkjIju/E2jh+PCHFeSlCH
	 bXqZu+ot7YdWlviNar2Egubvaaqnv+gwTk/9PTAswhA0tK7EPu2MGfGctP3xEiaclf
	 Hixz0GKs2Akwn43lxcEqiP6HCWATTektaSssAIkjAqb5SdtbCXgDPUHMgDowm6fTMw
	 6NmRqfGzW8Kr+gsrcHL67R03EEeG2nvm6ob8SNQrL+GKjgFp74m5PN1hU7dY6dWKPl
	 N1Xxyuz3pCwprGnegIuMgSTbCHmJvt0kWRcm1213rLxvmAGedsX94FXHuZlytvcrpb
	 lgy8JUVRb2/0A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 03/15] ACPI: button: Improve warning message regarding lid state
Date: Mon, 01 Jun 2026 18:56:33 +0200
Message-ID: <5084775.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12913564.O9o76ZdvQC@rafael.j.wysocki>
References: <12913564.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The warning message regarding an unexpected lid state printed by
acpi_lid_notify_state() is quite cryptic and there is no information
in it to indicate that it is about a platform firmware defect.  In
fact, it can only be understood after reading the comment below the
statement printing it.

For this reason, replace it with a more direct one including FW_BUG so
its connection to a firmware issue is clearer.

While at it, fix up a comment preceding the statement printing the
message in question.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0b96db762bea..d2c2b8105639 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -227,8 +227,8 @@ static int acpi_lid_notify_state(struct acpi_button *button, int state)
 				ms_to_ktime(lid_report_interval));
 	if (button->last_state == !!state &&
 	    ktime_after(ktime_get(), next_report)) {
-		/* Complain the buggy firmware */
-		pr_warn_once("The lid device is not compliant to SW_LID.\n");
+		/* Complain about the buggy firmware. */
+		pr_warn_once(FW_BUG "Unexpected lid state reported by firmware\n");
 
 		/*
 		 * Send the unreliable complement switch event:
-- 
2.51.0




