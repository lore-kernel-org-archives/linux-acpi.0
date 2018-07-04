From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ACPI / battery: safe unregistering of
 hooks
Date: Wed, 4 Jul 2018 11:43:37 +0200
Message-ID: <CAJZ5v0hwsR1KeDq60oD6a_NQYeENsRzeoF1qWOoGm9-arpassg@mail.gmail.com>
References: <20180623090851.GA5525@Mindship-03>
 <20180704092927.GA6544@Mindship-05.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20180704092927.GA6544-7Pk1HLXsvWqf6HGZUO+WniZi+YwRKgec@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jouke Witteveen <j.witteveen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 4, 2018 at 11:29 AM, Jouke Witteveen <j.witteveen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Jun 23, 2018 at 11:08:51AM +0200, Jouke Witteveen wrote:
>> As unregistering a hook takes it off the hook list, we should use a safe
>> for_each loop when we potentially unregister a hook.
>>
>> Signed-off-by: Jouke Witteveen <j.witteveen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>
> I would like to draw attention to this patch. It fixes a very noticable
> regression for owners of Thinkpad 13 laptops. The thinkpad_acpi driver
> currently does not support that line of laptops [1]. As a result, users
> cannot boot the 4.17 kernel on those machines.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=200333#c1

Well, care to put that information into  the patch changelog and
resend it, then?

Ideally, can you identify the kernel commit which introduced the regression?

>
>>  drivers/acpi/battery.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index b0113a58..d79ad844 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -717,10 +717,11 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>>                        */
>>                       pr_err("extension failed to load: %s", hook->name);
>>                       __battery_hook_unregister(hook, 0);
>> -                     return;
>> +                     goto end;
>>               }
>>       }
>>       pr_info("new extension: %s\n", hook->name);
>> +end:
>>       mutex_unlock(&hook_mutex);
>>  }
>>  EXPORT_SYMBOL_GPL(battery_hook_register);
>> @@ -732,7 +733,7 @@ EXPORT_SYMBOL_GPL(battery_hook_register);
>>  */
>>  static void battery_hook_add_battery(struct acpi_battery *battery)
>>  {
>> -     struct acpi_battery_hook *hook_node;
>> +     struct acpi_battery_hook *hook_node, *tmp;
>>
>>       mutex_lock(&hook_mutex);
>>       INIT_LIST_HEAD(&battery->list);
>> @@ -744,15 +745,15 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>>        * when a battery gets hotplugged or initialized
>>        * during the battery module initialization.
>>        */
>> -     list_for_each_entry(hook_node, &battery_hook_list, list) {
>> +     list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
>>               if (hook_node->add_battery(battery->bat)) {
>>                       /*
>>                        * The notification of the extensions has failed, to
>>                        * prevent further errors we will unload the extension.
>>                        */
>> -                     __battery_hook_unregister(hook_node, 0);
>>                       pr_err("error in extension, unloading: %s",
>>                                       hook_node->name);
>> +                     __battery_hook_unregister(hook_node, 0);
>>               }
>>       }
>>       mutex_unlock(&hook_mutex);
>> --
>> 2.18.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
