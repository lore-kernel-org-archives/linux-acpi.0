From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] ACPI: device property: Fix node lookup in acpi_graph_get_child_prop_value
Date: Tue, 22 Aug 2017 22:47:43 +0200
Message-ID: <CAJZ5v0hUh7+kP-ysLNA4-NM5cNpMUST6=3BrnwM=UYNSAvPfDw@mail.gmail.com>
References: <1503434398-8316-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34425 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753005AbdHVUro (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2017 16:47:44 -0400
Received: by mail-it0-f67.google.com with SMTP id s132so203381ita.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Aug 2017 13:47:44 -0700 (PDT)
In-Reply-To: <1503434398-8316-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Yang, Hyungwoo" <hyungwoo.yang@intel.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>

On Tue, Aug 22, 2017 at 10:39 PM, Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> acpi_graph_get_child_prop_value() is intended to find a child node with a
> certain property value pair. The check
>
>         if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
>                 continue;
>
> is faulty: fwnode_property_read_u32() returns zero on success, not on
> failure, leading to comparing values only if the searched property was not
> found.
>
> Fixes: 79389a83bc38 ("ACPI / property: Add support for remote endpoints")
> Reported-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> since v1:
>
> - fwnode_rpoperty_read_u32( fwnode -> child )
>
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a65c09c..3963098 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1052,7 +1052,7 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
>         fwnode_for_each_child_node(fwnode, child) {
>                 u32 nr;
>
> -               if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
> +               if (fwnode_property_read_u32(child, prop_name, &nr))

OK, but it looks like there are two bugs in it (the zero vs nonzero
return value and the first arg), but the changelog only mentions one
of them.

>                         continue;
>
>                 if (val == nr)
> --
