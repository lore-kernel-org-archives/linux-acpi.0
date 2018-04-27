From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: improve function documentation for acpi_parse_entries_array()
Date: Fri, 27 Apr 2018 13:04:20 +0200
Message-ID: <CAJZ5v0h+TcJg5iNFOFQYiXKmuN3+PWe8akx_0BT6jdfZ71yNwg@mail.gmail.com>
References: <20180424193505.6934-1-ahs3@redhat.com> <20180424193505.6934-2-ahs3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424193505.6934-2-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 24, 2018 at 9:35 PM, Al Stone <ahs3@redhat.com> wrote:
> I found the description of the table_size argument to the function
> acpi_parse_entries_array() unclear and ambiguous.  This is a minor
> documentation change to improve that description so I don't misuse
> the argument again in the future, and it is hopefully clearer to
> other future users.
>
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/tables.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 849c4fb19b03..21535762b890 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -222,7 +222,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>   * acpi_parse_entries_array - for each proc_num find a suitable subtable
>   *
>   * @id: table id (for debugging purposes)
> - * @table_size: single entry size
> + * @table_size: size of the root table; i.e., the offset from the very
> + *              first byte of the complete ACPI table, to the first byte
> + *              of the first subtable

But alas this needs to be one line.

You can add more details in the comment body below.

>   * @table_header: where does the table start?
>   * @proc: array of acpi_subtable_proc struct containing entry id
>   *        and associated handler with it
> @@ -400,7 +402,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
>                 return -ENODEV;
>  }

Thanks,
Rafael
