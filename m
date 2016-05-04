From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] device property: fix a potential oops
Date: Wed, 04 May 2016 23:11:21 +0200
Message-ID: <4978226.jACc6Brefu@vostro.rjw.lan>
References: <1461755060-138091-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55732 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752597AbcEDVIK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2016 17:08:10 -0400
In-Reply-To: <1461755060-138091-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, April 27, 2016 02:04:20 PM Heikki Krogerus wrote:
> Since fwnode may hold ERR_PTR(-ENODEV) or it may point to
> NULL, the fwnode type checks is_of_node(), is_acpi_node()
> and is is_pset_node() need to consider it. Using
> IS_ERR_OR_NULL() to check it.
> 
> Fixes: 0d67e0fa1664 ("device property: fix for a case of use-after-free")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied, thanks!

