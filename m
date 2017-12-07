From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
Date: Thu, 7 Dec 2017 15:15:29 -0500
Message-ID: <74f88482-71ff-db72-ee6e-cc9b3b0bc37e@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
 <20171207122948.yyl6adb6lnb56gok@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171207122948.yyl6adb6lnb56gok@valkosipuli.retiisi.org.uk>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/7/2017 7:29 AM, Sakari Ailus wrote:
> Hi Sinan,
> 
> Thanks for the update.
> 
> Just one small comment below.
> 
[snip]

>>  
>>  struct fwnode_handle {
>>  	struct fwnode_handle *secondary;
>> @@ -66,6 +67,7 @@ struct fwnode_reference_args {
>>   *			       endpoint node.
>>   * @graph_get_port_parent: Return the parent node of a port node.
>>   * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
>> + * @get_match_data: Return the driver match data.
> 
> Could you arrange the new get_match_data op closer to the other ops that
> don't deal with the graphs? Such as device_is_available. As the ops are
> dealing generally with fwnodes, I might call this device_get_match_data to
> explicitly mention it's for devices.

done

> 
>>   */
>>  struct fwnode_operations {
>>  	void (*get)(struct fwnode_handle *fwnode);
>> @@ -101,6 +103,8 @@ struct fwnode_operations {
>>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
>>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>>  				    struct fwnode_endpoint *endpoint);
>> +	void *(*get_match_data)(const struct fwnode_handle *fwnode,
>> +				struct device *dev);
> 
> Same comment about the order here.

ok

> 
>>  };
>>  
>>  #define fwnode_has_op(fwnode, op)				\
>> diff --git a/include/linux/property.h b/include/linux/property.h
>> index 6bebee1..01fa55b 100644
>> --- a/include/linux/property.h
>> +++ b/include/linux/property.h
>> @@ -275,6 +275,8 @@ int device_add_properties(struct device *dev,
>>  
>>  enum dev_dma_attr device_get_dma_attr(struct device *dev);
>>  
>> +void *device_get_match_data(struct device *dev);
>> +
>>  int device_get_phy_mode(struct device *dev);
>>  
>>  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
