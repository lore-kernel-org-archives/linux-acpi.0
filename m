From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v5 3/5] device property: Move fwnode graph ops to firmware
 specific locations
Date: Tue, 9 May 2017 15:36:49 +0300
Message-ID: <0e2194dc-f056-b405-b4f4-d977b9eacac7@linux.intel.com>
References: <1493882051-28814-1-git-send-email-sakari.ailus@linux.intel.com>
 <1493882051-28814-4-git-send-email-sakari.ailus@linux.intel.com>
 <CAL_JsqLCWnDiAbfvEp8h_USwpCho8Qd9ojCp3ebeG9CGdvPzvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:32533 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdEIMgz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 May 2017 08:36:55 -0400
In-Reply-To: <CAL_JsqLCWnDiAbfvEp8h_USwpCho8Qd9ojCp3ebeG9CGdvPzvQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Al Stone <ahs3@redhat.com>, Frank Rowand <frowand.list@gmail.com>

Hi Rob,

Thanks for the review.

On 05/08/17 21:23, Rob Herring wrote:
> On Thu, May 4, 2017 at 2:14 AM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
...
>> @@ -1184,24 +1167,11 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>>  struct fwnode_handle *
>>  fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
>>  {
>> -       struct fwnode_handle *parent = NULL;
>> -
>> -       if (is_of_node(fwnode)) {
>> -               struct device_node *node;
>> -
>> -               node = of_graph_get_remote_port_parent(to_of_node(fwnode));
>> -               if (node)
>> -                       parent = &node->fwnode;
>> -       } else if (is_acpi_node(fwnode)) {
>> -               int ret;
>> -
>> -               ret = acpi_graph_get_remote_endpoint(fwnode, &parent, NULL,
>> -                                                    NULL);
>> -               if (ret)
>> -                       return NULL;
>> -       }
>> +       fwnode = fwnode_graph_get_remote_port(fwnode);
>> +       if (!fwnode)
>> +               return NULL;
>>
>> -       return parent;
>> +       return fwnode_call_ptr_op(fwnode, graph_get_port_parent);
> 
> Just make fwnode_call_ptr_op(NULL, ...) return NULL.

Hmm. That already appears to be the case... I'll take that account
above, too.

> 
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
>>
>> @@ -1213,23 +1183,11 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
>>   */
>>  struct fwnode_handle *fwnode_graph_get_remote_port(struct fwnode_handle *fwnode)
>>  {
>> -       struct fwnode_handle *port = NULL;
>> -
>> -       if (is_of_node(fwnode)) {
>> -               struct device_node *node;
>> -
>> -               node = of_graph_get_remote_port(to_of_node(fwnode));
>> -               if (node)
>> -                       port = &node->fwnode;
>> -       } else if (is_acpi_node(fwnode)) {
>> -               int ret;
>> -
>> -               ret = acpi_graph_get_remote_endpoint(fwnode, NULL, &port, NULL);
>> -               if (ret)
>> -                       return NULL;
>> -       }
>> +       fwnode = fwnode_graph_get_remote_endpoint(fwnode);
>> +       if (!fwnode)
>> +               return NULL;
>>
>> -       return port;
>> +       return fwnode_get_parent(fwnode);
> 
> Just make fwnode_get_parent(NULL) return NULL.

The same.

> 
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
>>
>> @@ -1242,25 +1200,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
>>  struct fwnode_handle *
>>  fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
>>  {
>> -       struct fwnode_handle *endpoint = NULL;
>> -
>> -       if (is_of_node(fwnode)) {
>> -               struct device_node *node;
>> -
>> -               node = of_parse_phandle(to_of_node(fwnode), "remote-endpoint",
>> -                                       0);
>> -               if (node)
>> -                       endpoint = &node->fwnode;
>> -       } else if (is_acpi_node(fwnode)) {
>> -               int ret;
>> -
>> -               ret = acpi_graph_get_remote_endpoint(fwnode, NULL, NULL,
>> -                                                    &endpoint);
>> -               if (ret)
>> -                       return NULL;
>> -       }
>> -
>> -       return endpoint;
>> +       return fwnode_call_ptr_op(fwnode, graph_get_remote_endpoint);
>>  }
>>  EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
>>
>> @@ -1276,22 +1216,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
>>  int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
>>                                 struct fwnode_endpoint *endpoint)
>>  {
>> -       struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
>> -
>>         memset(endpoint, 0, sizeof(*endpoint));
>>
>> -       endpoint->local_fwnode = fwnode;
>> -
>> -       if (is_acpi_node(port_fwnode)) {
>> -               fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
>> -               fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
>> -       } else {
>> -               fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
>> -               fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
>> -       }
>> -
>> -       fwnode_handle_put(port_fwnode);
>> -
>> -       return 0;
>> +       return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
>>  }
>>  EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 984e37e..bb6ac73 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -869,6 +869,59 @@ static struct fwnode_handle *of_fwnode_get_named_child_node(
>>         return NULL;
>>  }
>>
>> +static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
>> +       struct fwnode_handle *fwnode, struct fwnode_handle *prev)
>> +{
>> +       struct device_node *node;
>> +
>> +       node = of_graph_get_next_endpoint(to_of_node(fwnode),
>> +                                         to_of_node(prev));
>> +       if (node)
>> +               return of_fwnode_handle(node);
>> +
>> +       return NULL;
> 
> Can't of_fwnode_handle() return NULL when node is NULL? Then these
> functions become one liners:
> 
> return of_fwnode_handle(of_graph_get_next_endpoint(to_of_node(fwnode),
>                                          to_of_node(prev)));

Good point. of_fwnode_handle() is a macro (in order to support const /
non-const cases) and it'll be a little bit more complex but I guess
that's not really an issue.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
