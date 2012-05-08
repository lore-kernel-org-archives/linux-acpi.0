From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] gts and bfs fixes (v3).
Date: Tue, 8 May 2012 23:38:45 +0200
Message-ID: <201205082338.45997.rjw@sisk.pl>
References: <1334687359-9970-1-git-send-email-konrad.wilk@oracle.com> <4FA8BDD1.6050608@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60002 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab2EHVdz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 May 2012 17:33:55 -0400
In-Reply-To: <4FA8BDD1.6050608@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ming.m.lin@intel.com, hpa@zytor.com, x86@kernel.org

On Tuesday, May 08, 2012, Len Brown wrote:
> Ugh.
> 
> I think instead we should go the other way
> and simply delete the code
> for _GTS and _BFS support.
> 
> The evidence is that while it is documented in the ACPI spec,
> no OS implements it -- for when we tried it, we found some
> systems that shipped AML that doesn't work.

Well, we can still remove it ...
 
> ps. yes, we should also petition the ACPI authors
> to remove _GTS and _BFS from an upcoming revision.

Oh, yes, I totally agree. :-)

Thanks,
Rafael
