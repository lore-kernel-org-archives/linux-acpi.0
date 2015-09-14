From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: tables: simplify acpi_parse_entries
Date: Tue, 15 Sep 2015 01:41 +0200
Message-ID: <1725643.HXZjLoU2vc@vostro.rjw.lan>
References: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58639 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751619AbbINXNC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2015 19:13:02 -0400
In-Reply-To: <1442243686-15845-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Monday, September 14, 2015 04:14:46 PM Sudeep Holla wrote:
> acpi_parse_entries passes the table end pointer to the sub-table entry
> handler. acpi_parse_entries itself could validate the end of an entry
> against the table end using the length in the sub-table entry.
> 
> This patch adds the validation of the sub-table entry end using the
> length field.This will help to eliminate the need to pass the table end
> to the handlers.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Well, I'm not a big fan of (void *) arithmetics and the patch seems to be
doing too much to me.

> ---
>  drivers/acpi/tables.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 17a6fa01a338..145d4f6a1c54 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -217,16 +217,13 @@ acpi_parse_entries(char *id, unsigned long table_size,
>  		int entry_id, unsigned int max_entries)
>  {
>  	struct acpi_subtable_header *entry;
> +	void *entry_end, *table_end;
>  	int count = 0;
> -	unsigned long table_end;

I'd keep that as unsigned long and I'd add unsigned long entry_end here.

>  
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> -	if (!id || !handler)
> -		return -EINVAL;
> -
> -	if (!table_size)
> +	if (!id || !handler || !table_size)
>  		return -EINVAL;

Please mention this cleanup bit in the changelog, as it is not related to
the other changes.

>  
>  	if (!table_header) {
> @@ -234,34 +231,21 @@ acpi_parse_entries(char *id, unsigned long table_size,
>  		return -ENODEV;
>  	}
>  
> -	table_end = (unsigned long)table_header + table_header->length;
> +	table_end = (void *)table_header + table_header->length;
>  
>  	/* Parse all entries looking for a match. */
> +	entry = (void *)table_header + table_size;
> +	entry_end = (void *)entry + entry->length;
>  
> -	entry = (struct acpi_subtable_header *)
> -	    ((unsigned long)table_header + table_size);

	entry_end = (unsigned long)table_header + table_size;
	entry = (struct acpi_subtable_header *)entry_end;
	entry_end += entry->length;

> -
> -	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
> -	       table_end) {
> +	while (entry->length && entry_end <= table_end) {

We used to return -EINVAL for entry->length == 0 and now we don't.  Isn't that
a problem?

>  		if (entry->type == entry_id
>  		    && (!max_entries || count < max_entries)) {
> -			if (handler(entry, table_end))
> +			if (handler(entry, (unsigned long)entry_end))
>  				return -EINVAL;
> -
>  			count++;
>  		}
> -
> -		/*
> -		 * If entry->length is 0, break from this loop to avoid
> -		 * infinite loop.
> -		 */
> -		if (entry->length == 0) {
> -			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
> -			return -EINVAL;
> -		}

Perhaps just reorder this with the previous if () and write the loop as

	while (entry_end <= table_end) {

> -
> -		entry = (struct acpi_subtable_header *)
> -		    ((unsigned long)entry + entry->length);
> +		entry = entry_end;
> +		entry_end = (void *)entry + entry->length;

And this can be

		entry = (struct acpi_subtable_header *)entry_end;
		entry_end += entry->length;

>  	}
>  
>  	if (max_entries && count > max_entries) {
> 

Thanks,
Rafael

