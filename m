Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11330397925
	for <linux-acpi@vger.kernel.org>; Mon, 31 Aug 2026 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788150474; cv=pass; b=XZivkM+yDrj1tANu5KHjc9CcgIkXae7xRZMoxlbHFK40Q/kgeJWBGmIXFh6y2WrVYKdwDVYTzxKIzZcalfSUfIhyTvcGvayOKWXQIPmA4Jn7slhUJWnMLiD2PcSlg/6PGVDSAVR0jMNf34RNhoCMNhkUeBJj7iH6jpY62Hu9t2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788150474; c=relaxed/simple;
	bh=FAxZP1r6MFSpLsu8CHrIlBjZa/TvAcgjBjWfXeKm0U4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eqpIYkuNqd2nR2CzF34PAbcLXWpEZINozADcvVI+DYHYo0O5lVXKSXBG0LPsHdLug4am2vVd0IHKdSXkylmaJp1aCV1ukV4SAtYo8/U3w7BBviVETMt4STiLftwkAqeROQy4h81GXwX2/aPL0GOORIT7aUu1Z+ydTbo5+zhbKzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRYkIQCl; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRYkIQCl"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb61bbeb25so3523136a34.1
        for <linux-acpi@vger.kernel.org>; Sun, 30 Aug 2026 21:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788150472; cv=none;
        d=google.com; s=arc-20260327;
        b=OmB/I1FLG3lcz2CQz5vb4Fyfi6SZ37FiYdfNt7mXxSrCbfMDGbcDXd39L0+DqnDpyr
         fEe4uRJ4QmtIGNepqCDdQzH3qiTgWYq41zuPL50sq7xCJRzKfsTND2a0vy+QEA8LmbfU
         QxqTCmM0+1Yfpl/HSau+ldJdlCykrt3wywmDpBkgci1DFAYj6aLxSDeFX9WtZ/zlsEgD
         I9yAqw/PYUpINP+9ipCrFaBBbKoVEvPWk7cQgV6tR2RZvcSUSwcT29GI4kGAF9m/lw3x
         FnNvYuWx5T0PvTv7b3PRdSZqwUjTEl4uEbS7r2Xpb30JcwkxRiKtbsNFZWZI3Z6Y5vHT
         8DxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w6cfHFWajG2mUYJ/SeqqbFWYHvEkw7VlhhOfJ39ntMs=;
        fh=RZ5zH9/kJCuxNnlBK1naQoLjTL/QQ5bmY8KxIzqZg2g=;
        b=fBNAXWz6TXnANnmGEmYpvddHF3rjlJ3Ay0Cnk1ghyGs7mTwDZURf7EBHETCzypoXYj
         Mn5tM3DDu7wagZJaMQjpZfipZ2WBEwIxrlwLKXniqhpLywJr/QB1lYTiw6xtN7cMl1Bd
         6HLIg3qW9tAugntakzAE0Dt+8Eu9h0g9LvZe7hzhGyxEM57mR4VYkM0h38EkIFoGmNT8
         aR/G17f2k9YOccxCnyLbZyBVLUXZ+IniIHyS6qUZZgOXUpC7mdBYSc4qB0fovz6WrVkG
         wrNaAIiNTQTMSmSxcw6I5708y2hymO4gcg9fEvdpFCywAvaBNPtFz322M6XPA59aDc4m
         SeRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788150472; x=1788755272; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w6cfHFWajG2mUYJ/SeqqbFWYHvEkw7VlhhOfJ39ntMs=;
        b=sRYkIQClqWjN1uGw86TsIpEyHwSaBRI0+RlCkiNX9e371n1OBCyhlyuWXkkH53VLkO
         8lzWjjWaQRQDvea+i0uFPflNwU/UXw1vuACUEsRq2eiIvxmauKS5NicU50bnlUs++SD+
         kH9vDvngJpspNW5jO8zrU2WMlot89NlIJUIP5whJMKNqWZYw9VAPhdAtM0Wow3l2fWlT
         WM9U1JUD+KeGrtE+/tW1V9BXXn+lr1JAf9LFpYM7B+BnLyQT6HimvFdmGKOc3cJ707oY
         nG+9BJetK06xkGpEbBHEQZghPRy6OZVATjy+/3BJt26K6rhitmrsTCOo8uQMq+Uyb+qg
         NFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788150472; x=1788755272;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w6cfHFWajG2mUYJ/SeqqbFWYHvEkw7VlhhOfJ39ntMs=;
        b=DibwrU/19glLuzXBChUfnZCIqEHXt2OCRkAchPu6sqs1aIcW0yqG6Rly/9U9JGWaRM
         VA5xaTjAhz2KAbT2cg3PnAecNtRpWjyxduI6KTupxcbXzMWMS3PN+UsMTgrg3JKuGlLi
         zq0BKTu0P276OClSdrKrYc4P8efQzNWjUexrRn+du3u441dT3mlV9PEreitKULLzHUlM
         MQKkqy0ZDPZ7YcOwlkEkKNJQ/fRMm/M14n+k4oX3kXCfEFAMDJWm93+bTvgO+Pr/Lz25
         1bWodXqnrc/sxHLMBg0T9hotXIspXlN9zIqHNM3vcp0yoVkG+4jHMaHjCm3uwsV5iNEz
         xhZw==
X-Gm-Message-State: AFuF++ltP/YtH1OQHLeYluOsFr/oJ5MrgS3eshCChtnx64b+JXu25ErT
	4TXV1GXKVwFYiFRO4F6IzdR9Ds4muC6XsFc7N4XGy6MHAnbzQFRBUNfF571H/XsH509rPA6mAh/
	vm9ZSbY6DHMBWXy3GbtoUuwEV5nb65JQGcbzF
X-Gm-Gg: AR+sD11aO41EjQj3rGfk0/W0sXr6V/NgUQnZXFzuv+HY4i+hl3wm5KuP62b9c4QEnbt
	FioI+StnzMQpfRtsi0K4o2Z0V+JBbFfTbdYP4wgMPZYlc3fn5K9BwxxDp9Q22EXIUR1wKPPTp5y
	rc3TsG5Jg0MuI8i5mZjGcZah6h31k+TZnEncOfUusUFLbxW8cxGx8U5bNFbYyMSTjzL1ubJ0KwH
	bHTDfqxXdC1ShcFjrRd8PrxQNWIEsgBZN1HDd89vYUsX5WheA/kQYhx1ePsNPgv1H6LZEEVUQlB
	84l3s7NtUxPJxm65vgYQSYcqkV8j7WmAdny2q2pAGZ6TBLgdPn+GQGOJjEDbm/m66ny4msagXUZ
	gy7Vd0VsO3W10
X-Received: by 2002:a05:6808:538f:b0:4aa:cad:cb4c with SMTP id
 5614622812f47-4b398037d1emr29237479b6e.1.1788150471810; Sun, 30 Aug 2026
 21:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Date: Mon, 31 Aug 2026 06:27:39 +0200
X-Gm-Features: AcwNN1WWlRQQDc_CVWJFU7tdu_Z7mCSVr31qkPoeVGpqgtO5des00QYjtXXtn44
Message-ID: <CAPAw8HGxmd2V5GgjL191f3pwOnbuGp4cfDaxCWiR57EquLOecw@mail.gmail.com>
Subject: [PATCH] ACPICA: Parser: do not set the AML pointer to a NULL AmlLastWhile
To: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"

AcpiPsNextParseState() can set ParserState->Aml to NULL, after which the parse
loop dereferences it in AcpiPsPeekOpcode(). A malformed ACPI table supplied by
firmware therefore panics the kernel in PID 1 during acpi_init(), before
userspace exists - the machine does not boot.

This is the largest of a set of related findings: it accounts for 110 of 189
malformed SSDTs that leave a stock x86_64_defconfig kernel unbootable
(tested on pristine Linux 7.2.2 - tag: v7.2.2). The smallest trigger
is a 46-byte table containing no While, Break or Continue at all.

WalkState->AmlLastWhile is only ever assigned in AcpiDsExecEndOp() while
handling a While loop, so outside a loop it is still NULL from the zeroed walk
state. AcpiPsNextParseState() assigns it to ParserState->Aml for AE_CTRL_BREAK,
AE_CTRL_CONTINUE and AE_CTRL_PENDING.

The first two are guarded at their source; AE_CTRL_PENDING is not, and it is not
a loop-only status. AcpiExNameSegment() returns it for any name segment that
starts with a digit or a non-alpha character - entirely controlled by the AML
being parsed, with no loop involved. AcpiPsPeekOpcode()'s bounds check does not
help, because NULL < AmlEnd passes.

In Linux this is reached from AcpiTbLoadNamespace() during acpi_init(), so a
table supplied by firmware faults in PID 1 inside do_one_initcall() and
panics the kernel before userspace exists:

  BUG: kernel NULL pointer dereference at 0000000000000000
  RIP: 0010:acpi_ps_peek_opcode+0x16/0x40
   acpi_ps_get_next_arg / acpi_ps_parse_loop / acpi_ps_parse_aml
   acpi_ns_load_table / acpi_tb_load_namespace / acpi_init
  Kernel panic - not syncing: Attempted to kill init!

Refuse to take the branch when AmlLastWhile is NULL and fail the parse with
AE_AML_NO_WHILE, whose existing text is "Break or Continue without a While".
Also NULL-check WalkState->ControlState on the two paths that dereference it;
the AE_CTRL_FALSE comment already says "a predicate (if any)".

One detail worth keeping if you rework the patch: it also sets
ParserState->Aml = ParserState->AmlEnd on the error paths. That is required, not
cosmetic. During a table load AcpiPsParseLoop() deliberately converts AML
exceptions back to AE_OK ("keep trying to load the table"), so an error return
that does not advance the AML pointer re-parses the same position forever. An
earlier version of this patch omitted it and turned one table's panic into a
hang.

Why this matters beyond "bad firmware breaks your machine": under confidential
computing the host is untrusted by design and supplies the guest's ACPI tables.
Documentation/security/snp-tdx-threat-model.rst lists "Malformed runtime input"
from a misbehaving host in its guest threat matrix. That is the model in which
these are security bugs rather than robustness bugs.

Reproducer, evidence and step-by-step instructions can be found at the
issue reported here:
https://github.com/open-acpica/acpica/issues/1226

Sending this to the public list rather than security@kernel.org: the attacker
must already control the platform firmware, no control over the faulting
pointer was demonstrated, and the fix is small with nothing to coordinate.
Say so explicitly if you would rather it had gone elsewhere.

Signed-off-by: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
---
diff --git a/source/components/parser/psparse.c
b/source/components/parser/psparse.c
index 1aacc0c..7fb28dc 100644
--- a/source/components/parser/psparse.c
+++ b/source/components/parser/psparse.c
@@ -338,6 +338,15 @@ AcpiPsNextParseState (

     case AE_CTRL_BREAK:

+        if (!WalkState->AmlLastWhile || !WalkState->ControlState)
+        {
+            ACPI_ERROR ((AE_INFO,
+                "Break without a valid enclosing While"));
+            ParserState->Aml = ParserState->AmlEnd;
+            Status = AE_AML_NO_WHILE;
+            break;
+        }
+
         ParserState->Aml = WalkState->AmlLastWhile;
         WalkState->ControlState->Common.Value = FALSE;
         Status = AE_CTRL_BREAK;
@@ -345,12 +354,30 @@ AcpiPsNextParseState (

     case AE_CTRL_CONTINUE:

+        if (!WalkState->AmlLastWhile)
+        {
+            ACPI_ERROR ((AE_INFO,
+                "Continue without a valid enclosing While"));
+            ParserState->Aml = ParserState->AmlEnd;
+            Status = AE_AML_NO_WHILE;
+            break;
+        }
+
         ParserState->Aml = WalkState->AmlLastWhile;
         Status = AE_CTRL_CONTINUE;
         break;

     case AE_CTRL_PENDING:

+        if (!WalkState->AmlLastWhile)
+        {
+            ACPI_ERROR ((AE_INFO,
+                "Pending control state without a valid enclosing While"));
+            ParserState->Aml = ParserState->AmlEnd;
+            Status = AE_AML_NO_WHILE;
+            break;
+        }
+
         ParserState->Aml = WalkState->AmlLastWhile;
         break;

@@ -391,7 +418,10 @@ AcpiPsNextParseState (

         /* In the case of a BREAK, just force a predicate (if any) to FALSE */

-        WalkState->ControlState->Common.Value = FALSE;
+        if (WalkState->ControlState)
+        {
+            WalkState->ControlState->Common.Value = FALSE;
+        }
         Status = AE_CTRL_END;
         break;
