From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] laptops: move laptop-mode.txt to Documentation/laptops/
Date: Wed, 12 Mar 2008 02:45:58 -0400
Message-ID: <200803120245.59329.lenb@kernel.org>
References: <20080304134126.a0088c81.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45141 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbYCLGqY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 02:46:24 -0400
In-Reply-To: <20080304134126.a0088c81.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, bart@samwel.tk

Applied.

thanks,
-Len

On Tuesday 04 March 2008, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> cc: Bart Samwel (bart@samwel.tk)
> 
> Move laptop-mode.txt into the laptops/ sub-directory to consolidate
> laptop doc files there.
> 
> Update references to the file's location.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  Documentation/00-INDEX                |    2 
>  Documentation/filesystems/proc.txt    |    4 
>  Documentation/laptop-mode.txt         |  950 ------------------------
>  Documentation/laptops/00-INDEX        |    2 
>  Documentation/laptops/laptop-mode.txt |  950 ++++++++++++++++++++++++
>  5 files changed, 954 insertions(+), 954 deletions(-)
