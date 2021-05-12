Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0FC433ED
	for <linux-acpi@archiver.kernel.org>; Wed, 12 May 2021 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323A661177
	for <linux-acpi@archiver.kernel.org>; Wed, 12 May 2021 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhELMxi (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 12 May 2021 08:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhELMxI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 08:53:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7D7B61447;
        Wed, 12 May 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823907;
        bh=vwTUqn36ML6ajAEdHAKpanFk2OUa6HzYgc1kX05aesA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9DZiHtdV0i2aL3Kh/usGL9MH5RqPeivQDpZK30m6Gqzr4qIHzSnAPQ/KJnH/A8e6
         6hld0QS90gWmvDN8+KWL+ZpKuIbTWKMX/QlSgKhyFnPY2fYeNE2mZOC2SREGr7nuLx
         TZk+6QtJFV7RVFQS6RDkMKR3NbXibAPwt0CgS5JKWtsZi4yxKxjEoM7eo52l/3CrRv
         Z9lvVu7tC09h6t5rocfXPG8Plf1RBFOCirc6ILs8OtnqBFP5MTRLxRGuRsul+Ya62K
         GoF+uEAamAuLvfBSe724xjgP1+FoeaKX/QyVvOBt6kPqmnnDuzlZKXIAOvkbCNZAJv
         +1tb9gLH6de1Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoL3-0018nr-SF; Wed, 12 May 2021 14:51:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/40] docs: firmware-guide: acpi: dsd: graph.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:42 +0200
Message-Id: <afeeee8d52dac14c8e86e326b8fcee300dcb0d59.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/firmware-guide/acpi/dsd/graph.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 7072db801aeb..954b99ec6b77 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -159,7 +159,7 @@ References
 
 [2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
 
-[3] Documentation/devicetree/bindings/graph.txt
+[3] Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
     https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
-- 
2.30.2

