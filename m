From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/5]acpi:glue.c Fix warning: variable 'ret' set but not used
Date: Fri, 02 Jul 2010 01:10:45 +0100
Message-ID: <19422.1278029445@redhat.com>
References: <4C2CF400.20507@gmail.com> <4C2B9F49.8090304@gmail.com> <4C2A6B6C.1000306@gmail.com> <4C29674C.9070503@gmail.com> <4C28E14D.5050701@gmail.com> <1277621246-10960-4-git-send-email-justinmattock@gmail.com> <1277621246-10960-1-git-send-email-justinmattock@gmail.com> <7214.1277729293@redhat.com> <8066.1277750854@redhat.com> <22319.1277826461@redhat.com> <25800.1277889215@redhat.com> <16513.1277976706@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254Ab0GBAK6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 20:10:58 -0400
In-Reply-To: <4C2CF400.20507@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Justin P. Mattock <justinmattock@gmail.com> wrote:

> a bit confused with the whole:  "?:" though
> *condition ? value if true : value if false* (what if both are true
> what if both are false or does it matter?)

If you say:

	cond ?: false_value

then you'll get cond if cond is non-zero and false_value if it isn't.

I suspect it's a gccism.

David
